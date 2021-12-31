#!/bin/bash
#!/bin/bash

if amixer -c 0 get Master | grep -q off;
then
amixer set Master unmute
amixer set Speaker unmute
amixer set Headphone unmute
else
amixer set Master mute
amixer set Headphone mute
fi

#/usr/bin/amixer set Master toggle
#/usr/bin/amixer set Speaker toggle
bash ~/scripts/dwm-status-refresh.sh
