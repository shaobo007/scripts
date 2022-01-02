#!/bin/bash
#
#脚本功能描述：依据/proc/stat文件获取并计算CPU使用率
#
#CPU时间计算公式：CPU_TIME=user+system+nice+idle+iowait+irq+softirq
#CPU使用率计算公式：cpu_usage=(idle2-idle1)/(cpu2-cpu1)*100
#默认时间间隔
#TIME_INTERVAL=1
#time=$(date "+%Y-%m-%d %H:%M:%S")
##echo $time
#LAST_CPU_INFO=$(cat /proc/stat | grep -w cpu | awk '{print $2,$3,$4,$5,$6,$7,$8}')
#LAST_SYS_IDLE=$(echo $LAST_CPU_INFO | awk '{print $4}')
#LAST_TOTAL_CPU_T=$(echo $LAST_CPU_INFO | awk '{print $1+$2+$3+$4+$5+$6+$7}')
#sleep ${TIME_INTERVAL}
#NEXT_CPU_INFO=$(cat /proc/stat | grep -w cpu | awk '{print $2,$3,$4,$5,$6,$7,$8}')
#NEXT_SYS_IDLE=$(echo $NEXT_CPU_INFO | awk '{print $4}')
#NEXT_TOTAL_CPU_T=$(echo $NEXT_CPU_INFO | awk '{print $1+$2+$3+$4+$5+$6+$7}')

###系统空闲时间
#SYSTEM_IDLE=`echo ${NEXT_SYS_IDLE} ${LAST_SYS_IDLE} | awk '{print $1-$2}'`
###CPU总时间
#TOTAL_TIME=`echo ${NEXT_TOTAL_CPU_T} ${LAST_TOTAL_CPU_T} | awk '{print $1-$2}'`
#CPU_USAGE=`echo ${SYSTEM_IDLE} ${TOTAL_TIME} | awk '{printf "%.2f", 100-$1/$2*100}'`

#echo "CPU Usage:${CPU_USAGE}%"
#!/bin/bash
# by Paul Colby (http://colby.id.au), no rights reserved ;)

function get_weather() {
  LOCATION=Hangzhou

  printf "%s" "$SEP1"
  if [ "$IDENTIFIER" = "unicode" ]; then
    printf "%s" "$(curl -s wttr.in?format="%C+%t")"
  else
    printf "WEA %s" "$(curl -s wttr.in/$LOCATION?format=3 | grep -o "[0-9].*")"
  fi
  printf "%s\n" "$SEP2"
}

function get_bytes {
  # Find active network interface
  interface=$(ip route get 8.8.8.8 2>/dev/null| awk '{print $5}')
  line=$(grep $interface /proc/net/dev | cut -d ':' -f 2 | awk '{print "received_bytes="$1, "transmitted_bytes="$9}')
  eval $line
  now=$(date +%s%N)
}

# Function which calculates the speed using actual and old byte number.
# Speed is shown in KByte per second when greater or equal than 1 KByte per second.
# This function should be called each second.

function get_velocity {
  value=$1
  old_value=$2
  now=$3

  timediff=$(($now - $old_time))
  velKB=$(echo "1000000000*($value-$old_value)/1024/$timediff" | bc)
  if test "$velKB" -gt 1024
  then
    echo $(echo "scale=2; $velKB/1024" | bc)MB/s
  else
    echo ${velKB}KB/s
  fi
}

print_volume(){
  VOL=$(amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
  TOGVOL="$(amixer get Master | tail -n1 | sed -r 's/.*\[.*\].*\[.*\].*\[(.*)].*/\1/')"
  printf "%s" "$SEP1"
  if [ "$IDENTIFIER" = "unicode" ]; then
    if test "$VOL" -eq 0  || test "$TOGVOL" = "off"; then
      printf "🔇"
    elif [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
      printf "🔈 %s%%" "$VOL"
    elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
      printf "🔉 %s%%" "$VOL"
    else
      printf "🔊 %s%%" "$VOL"
    fi
  else
    if test "$VOL" -eq 0 || test "$TOGVOL" = "off"; then
      printf "MUTE"
    elif [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
      printf "VOL %s%%" "$VOL"
    elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
      printf "VOL %s%%" "$VOL"
    else
      printf "VOL %s%%" "$VOL"
    fi
  fi
  printf "%s\n" "$SEP2"
}
print_mem_per(){
  MEMTOT=$(free -m | sed -n '2p' | awk '{print $2}')
  MEMUSED=$(free -m | sed -n '2p' | awk '{print $3}')
  MEMFREE=$(free -m | sed -n '2p' | awk '{print $4}')
  #MEMSHARED=$(free -m | sed -n '2p' | awk '{print $5}')
  #MEMBUFF=$(free -m | sed -n '2p' | awk '{print $6}')
  #MEMCACHE=$(free -m | sed -n '2p' | awk '{print $7}')
  MEMRATE=`echo "scale=2;$MEMUSED/$MEMTOT" | bc | awk -F. '{print $2}' | sed -e 's/^[0]*//g'`
  # CPU temperature
  #CPU=$(sysctl -n hw.sensors.cpu0.temp0 | cut -d. -f1)

  printf "%s" "$SEP1"
  if [ "$IDENTIFIER" = "unicode" ]; then
    printf "💿 %s" "${MEMRATE}%"
  else
    printf "STA | MEM %s" "${MEMRATE}%"
  fi
  printf "%s\n" "$SEP2"
  #memfree=$(($(grep -m1 'MemAvailable:' /proc/meminfo | awk '{print $2}') / 1024))
  #echo -e "$memfree"
}

print_temp(){
  test -f /sys/class/thermal/thermal_zone0/temp || return 0
  echo $(head -c 2 /sys/class/thermal/thermal_zone0/temp)C
}

print_gpu_stat(){
  GPU_TEM=$(nvidia-smi | sed -n '10p' | awk '{print $3}')
  GPU_MEMUSED=$(nvidia-smi | sed -n '10p' | awk '{print $9}' | sed -r 's/(.*)MiB/\1/')
  GPU_MEMTOT=$(nvidia-smi | sed -n '10p' | awk '{print $11}' | sed -r 's/(.*)MiB/\1/')
  GPU_UTI=$(nvidia-smi | sed -n '10p' | awk '{print $13}' )
  #printf "| GPU %s %s/%s %s" "${GPU_TEM}" "${GPU_MEMUSED}" "${GPU_MEMTOT}" "${GPU_UTI}"
  printf " %s/%s %s"  "${GPU_MEMUSED}" "${GPU_MEMTOT}" "${GPU_UTI}"

}

get_time_until_charged() {

  # parses acpitool's battery info for the remaining charge of all batteries and sums them up
  sum_remaining_charge=$(acpitool -B | grep -E 'Remaining capacity' | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc);

  # finds the rate at which the batteries being drained at
  present_rate=$(acpitool -B | grep -E 'Present rate' | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc);
  if test $present_rate -gt 0;
  then
    # divides current charge by the rate at which it's falling, then converts it into seconds for `date`
    seconds=$(bc <<< "scale = 10; ($sum_remaining_charge / $present_rate) * 3600");

  # prettifies the seconds into h:mm:ss format
  pretty_time=$(date -u -d @${seconds} +%T);

  echo $pretty_time;
  fi

}

get_battery_combined_percent() {

  # get charge of all batteries, combine them
  #total_charge=$(expr $(acpi -b | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc));
  total_charge=$(expr $(acpi -b | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc));

  # get amount of batteries in the device
  #battery_number=$(acpi -b | wc -l);

  percent=$(expr $total_charge);

  echo $percent;
}

get_battery_charging_status() {

  if $(acpitool -b | grep --quiet Discharging)
  then
    echo "🔋";
  else # acpi can give Unknown or Charging if charging, https://unix.stackexchange.com/questions/203741/lenovo-t440s-battery-status-unknown-but-charging
    echo "🔌";
  fi
}

print_bat(){
  echo "$(get_battery_charging_status) $(get_battery_combined_percent)% $(get_time_until_charged )";
}

print_date(){
  printf "📆 %s" "$(date "+%a %b %d %Y %H:%M")"
  #date '📆 +%a %d-%m-%Y %H:%M'
}

show_record(){
  test -f /tmp/r2d2 || return
  rp=$(cat /tmp/r2d2 | awk '{print $2}')
  size=$(du -h $rp | awk '{print $1}')
  echo " $size $(basename $rp)"
}

PREV_TOTAL=0
PREV_IDLE=0

LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")
export IDENTIFIER="unicode"
while true; do
  # Get the total CPU statistics, discarding the 'cpu ' prefix.
  CPU=(`sed -n 's/^cpu\s//p' /proc/stat`)
  IDLE=${CPU[3]} # Just the idle CPU time.

# Get initial values
  get_bytes
  old_received_bytes=$received_bytes
  old_transmitted_bytes=$transmitted_bytes
  old_time=$now

  get_bytes
  #💿
  # Calculates speeds
  vel_recv=$(get_velocity $received_bytes $old_received_bytes $now)
  vel_trans=$(get_velocity $transmitted_bytes $old_transmitted_bytes $now)

  #xsetroot -name "  $(get_weather) $(print_mem_per) $(print_gpu_stat) 🌐⬇️ $vel_recv ⬆️ $vel_trans $(dwm_alsa) |$(print_bat)|$(show_record) $(print_date) "
  xsetroot -name "  $(get_weather)  $DIFF_USAGE% $(print_mem_per) 🌐⬇️$vel_recv ⬆️$vel_trans $(print_volume) |$(print_bat)|$(show_record) $(print_date) "
  # Update old values to perform new calculations
  old_received_bytes=$received_bytes
  old_transmitted_bytes=$transmitted_bytes
  old_time=$now
  #exit 0
  # Calculate the total CPU time.
  TOTAL=0
  for VALUE in "${CPU[@]}"; do
    let "TOTAL=$TOTAL+$VALUE"
  done

  # Calculate the CPU usage since we last checked.
  let "DIFF_IDLE=$IDLE-$PREV_IDLE"
  let "DIFF_TOTAL=$TOTAL-$PREV_TOTAL"
  let "DIFF_USAGE=(1000*($DIFF_TOTAL-$DIFF_IDLE)/$DIFF_TOTAL+5)/10"
  echo -en "\rCPU: $DIFF_USAGE% "

  # Remember the total and idle CPU times for the next check.
  PREV_TOTAL="$TOTAL"
  PREV_IDLE="$IDLE"

  # Wait before checking again.
  sleep 1
done 
#get_cpu_stat(){
  #read cpu a b c previdle rest < /proc/stat
  #prevtotal=$((a+b+c+previdle))
  #sleep 0.5
  #read cpu a b c idle rest < /proc/stat
  #total=$((a+b+c+idle))
  #cpu=$((100*((total-prevtotal)-(idle-previdle)) / (total-prevtotal)))
  #echo -e "$cpu% cpu"
#}
#while true;do
  #get_cpu_stat
  #sleep 1
#done 
##print_gpu(){
  ##GPU_TEM=$(nvidia-smi | sed -n '10p' | awk '{print $3}')
  ##GPU_MEMUSED=$(nvidia-smi | sed -n '10p' | awk '{print $9}' | sed -r 's/(.*)MiB/\1/')
  ##GPU_MEMTOT=$(nvidia-smi | sed -n '10p' | awk '{print $11}' | sed -r 's/(.*)MiB/\1/')
  ##GPU_UTI=$(nvidia-smi | sed -n '10p' | awk '{print $13}' )
  ###GPU_MEMRATE=`echo "scale=2;$GPU_MEMUSED/$GPU_MEMTOT" | bc | awk -F. '{print $2}'`
  ###echo $GPU_MEMRATE
  ##printf "GPU %s %s/%s %s" "${GPU_TEM}" "${GPU_MEMUSED}" "${GPU_MEMTOT}" "${GPU_UTI}"


##}
###print_gpu
###!/bin/bash
##echo `date`
###cpu use threshold
##cpu_threshold='80'
 ###mem idle threshold
##mem_threshold='100'
 ###disk use threshold
##disk_threshold='90'
###---cpu
##cpu_usage () {
##cpu_idle=`top -b -n 1 | grep Cpu | awk '{print $8}'|cut -f 1 -d "."`
##cpu_use=`expr 100 - $cpu_idle`
##echo ": $cpu_use"
###if [ $cpu_use -gt $cpu_threshold ]
    ###then
        ###echo "cpu warning!!!"
    ###else
        ###echo "cpu ok!!!"
###fi
##}
###---mem
##mem_usage () {
 ###MB units
##mem_free=`free -m | grep "Mem" | awk '{print $4+$6}'`
 ##echo "memory space remaining : $mem_free MB"
##if [ $mem_free -lt $mem_threshold  ]
    ##then
        ##echo "mem warning!!!"
    ##else
        ##echo "mem ok!!!"
##fi
##}
###---disk
##disk_usage () {
##disk_use=`df -P | grep /dev | grep -v -E '(tmp|boot)' | awk '{print $5}' | cut -f 1 -d "%"`
 ##echo "disk usage : $disk_use" 
##if  test $disk_use -gt $disk_threshold 
##then
        ##echo "disk warning!!!"
##else
        ##echo "disk ok!!!"
##fi
 
 
##}
###cpu_usage
###mem_usage
###disk_usage
