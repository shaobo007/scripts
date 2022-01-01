#!/bin/bash
# Screenshot: http://s.natalian.org/2013-08-17/dwm_status.png
# Network speed stuff stolen from http://linuxclues.blogspot.sg/2009/11/shell-script-show-network-speed.html

# This function parses /proc/net/dev file searching for a line containing $interface data.
# Within that line, the first and ninth numbers after ':' are respectively the received and transmited bytes.

function get_weather() {
  LOCATION=Hangzhou

  printf "%s" "$SEP1"
  if [ "$IDENTIFIER" = "unicode" ]; then
    printf "%s" "$(curl -s wttr.in/$LOCATION?format=1)"
  else
    printf "WEA %s" "$(curl -s wttr.in/$LOCATION?format=1 | grep -o "[0-9].*")"
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

# Get initial values
get_bytes
old_received_bytes=$received_bytes
old_transmitted_bytes=$transmitted_bytes
old_time=$now

#print_volume() {
#volume="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
#togvol="$(amixer get Master | tail -n1 | sed -r 's/.*\[.*\].*\[.*\].*\[(.*)\].*/\1/')"
#if test "$volume" -gt 0 && test "$togvol"=="on";
#then
#echo -e "\uE05D${volume}"
#else
#echo -e "Mute"
#fi
#}

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

#get_cpu_stat(){
#CPU_IDLE=`top -b -n 1 | grep Cpu | awk '{print $8}'|cut -f 1 -d "."`
#CPU_USE=`expr 100 - $CPU_IDLE`
#echo "💻 $CPU_USE%"
#}

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
  total_charge=$(expr $(acpi -b | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc));

  # get amount of batteries in the device
  battery_number=$(acpi -b | wc -l);

  percent=$(expr $total_charge / $battery_number);

  echo $percent;
}

get_battery_charging_status() {

  if $(acpi -b | grep --quiet Discharging)
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


LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")
export IDENTIFIER="unicode"

get_bytes
#💿
# Calculates speeds
vel_recv=$(get_velocity $received_bytes $old_received_bytes $now)
vel_trans=$(get_velocity $transmitted_bytes $old_transmitted_bytes $now)

#xsetroot -name "  $(get_weather) $(print_mem_per) $(print_gpu_stat) 🌐⬇️ $vel_recv ⬆️ $vel_trans $(dwm_alsa) |$(print_bat)|$(show_record) $(print_date) "
xsetroot -name "  $(get_weather) $(print_mem_per) 🌐⬇️ $vel_recv ⬆️ $vel_trans $(print_volume) |$(print_bat)|$(show_record) $(print_date) "
print_mem_per
# Update old values to perform new calculations
old_received_bytes=$received_bytes
old_transmitted_bytes=$transmitted_bytes
old_time=$now

exit 0
