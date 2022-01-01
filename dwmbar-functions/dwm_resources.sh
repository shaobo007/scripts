#!/bin/sh

# A dwm_bar function to display information regarding system memory, CPU temperature, and storage
# Joe Standring <git@joestandring.com>
# GNU GPLv3

dwm_resources () {
    # Used and total memory
    MEMTOT=$(free -m | sed -n '2p' | awk '{print $2}')
    MEMUSED=$(free -m | sed -n '2p' | awk '{print $3}')
    MEMFREE=$(free -m | sed -n '2p' | awk '{print $4}')
    MEMSHARED=$(free -m | sed -n '2p' | awk '{print $5}')
    MEMBUFF=$(free -m | sed -n '2p' | awk '{print $6}')
    MEMCACHE=$(free -m | sed -n '2p' | awk '{print $7}')
    MEMRATE=`echo "scale=2;$MEMUSED/$MEMTOT" | bc | awk -F. '{print $2}'`
    #echo -e "total\tused\tfree\tshared\tbuffer\tavailable"
    #echo -e "${total}M\t${used}M\t${free}M\t${shared}M\t${buff}M\t${cached}M\nrate:${rate}%"
    #if    [ $rate -ge 80 ]
    #then    echo "Memory Warn"
        #ps aux | grep -v USER | sort -rn -k4 | head
    #fi
    # CPU temperature
    #CPU=$(sysctl -n hw.sensors.cpu0.temp0 | cut -d. -f1)
    # Used and total storage in /home (rounded to 1024B)
    STOUSED=$(df -h | grep '/home$' | awk '{print $3}')
    STOTOT=$(df -h | grep '/home$' | awk '{print $2}')
    STOPER=$(df -h | grep '/home$' | awk '{print $5}')
    echo $STOPER

    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
        printf "💻 MEM %s/%s CPU %s STO %s/%s: %s" "$MEMUSED" "$MEMTOT" "$CPU" "$STOUSED" "$STOTOT" "$STOPER"
    else
        printf "STA | MEM %s CPU %s STO %s/%s: %s" "${MEMRATE}%"  "$CPU" "$STOUSED" "$STOTOT" "$STOPER"
    fi
    printf "%s\n" "$SEP2"
}
#!/bin/bash
#
#total=$(free -m | sed -n '2p' | awk '{print $2}')
#used=$(free -m | sed -n '2p' | awk '{print $3}')
#free=$(free -m | sed -n '2p' | awk '{print $4}')
#shared=$(free -m | sed -n '2p' | awk '{print $5}')
#buff=$(free -m | sed -n '2p' | awk '{print $6}')
#cached=$(free -m | sed -n '2p' | awk '{print $7}')
#rate=`echo "scale=2;$used/$total" | bc | awk -F. '{print $2}'`
#echo -e "total\tused\tfree\tshared\tbuffer\tavailable"
#echo -e "${total}M\t${used}M\t${free}M\t${shared}M\t${buff}M\t${cached}M\nrate:${rate}%"
#if    [ $rate -ge 80 ]
#then    echo "Memory Warn"
    #ps aux | grep -v USER | sort -rn -k4 | head
#fi
dwm_resources
