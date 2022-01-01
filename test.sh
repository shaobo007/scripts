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

PREV_TOTAL=0
PREV_IDLE=0

while true; do
  # Get the total CPU statistics, discarding the 'cpu ' prefix.
  CPU=(`sed -n 's/^cpu\s//p' /proc/stat`)
  IDLE=${CPU[3]} # Just the idle CPU time.

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
  sleep 0.5
done &
get_cpu_stat(){
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*((total-prevtotal)-(idle-previdle)) / (total-prevtotal)))
  echo -e "$cpu% cpu"
}
while true;do
  get_cpu_stat
  sleep 1
done 
#print_gpu(){
  #GPU_TEM=$(nvidia-smi | sed -n '10p' | awk '{print $3}')
  #GPU_MEMUSED=$(nvidia-smi | sed -n '10p' | awk '{print $9}' | sed -r 's/(.*)MiB/\1/')
  #GPU_MEMTOT=$(nvidia-smi | sed -n '10p' | awk '{print $11}' | sed -r 's/(.*)MiB/\1/')
  #GPU_UTI=$(nvidia-smi | sed -n '10p' | awk '{print $13}' )
  ##GPU_MEMRATE=`echo "scale=2;$GPU_MEMUSED/$GPU_MEMTOT" | bc | awk -F. '{print $2}'`
  ##echo $GPU_MEMRATE
  #printf "GPU %s %s/%s %s" "${GPU_TEM}" "${GPU_MEMUSED}" "${GPU_MEMTOT}" "${GPU_UTI}"


#}
##print_gpu
##!/bin/bash
#echo `date`
##cpu use threshold
#cpu_threshold='80'
 ##mem idle threshold
#mem_threshold='100'
 ##disk use threshold
#disk_threshold='90'
##---cpu
#cpu_usage () {
#cpu_idle=`top -b -n 1 | grep Cpu | awk '{print $8}'|cut -f 1 -d "."`
#cpu_use=`expr 100 - $cpu_idle`
#echo ": $cpu_use"
##if [ $cpu_use -gt $cpu_threshold ]
    ##then
        ##echo "cpu warning!!!"
    ##else
        ##echo "cpu ok!!!"
##fi
#}
##---mem
#mem_usage () {
 ##MB units
#mem_free=`free -m | grep "Mem" | awk '{print $4+$6}'`
 #echo "memory space remaining : $mem_free MB"
#if [ $mem_free -lt $mem_threshold  ]
    #then
        #echo "mem warning!!!"
    #else
        #echo "mem ok!!!"
#fi
#}
##---disk
#disk_usage () {
#disk_use=`df -P | grep /dev | grep -v -E '(tmp|boot)' | awk '{print $5}' | cut -f 1 -d "%"`
 #echo "disk usage : $disk_use" 
#if  test $disk_use -gt $disk_threshold 
#then
        #echo "disk warning!!!"
#else
        #echo "disk ok!!!"
#fi
 
 
#}
##cpu_usage
##mem_usage
##disk_usage
