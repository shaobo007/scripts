#!/bin/bash

/bin/bash ~/scripts/dwm-status.sh &
/bin/bash ~/scripts/wp-autochange.sh &
#picom -o 0.95 -i 0.88 --detect-rounded-corners --vsync --blur-background-fixed -f -D 5 -c -b
sxhkd &
compton &
#/bin/bash ~/scripts/tap-to-click.sh &
#/bin/bash ~/scripts/inverse-scroll.sh &
nm-applet &
blueman-applet &
xfce4-power-manager &
./bin/start-vpn &
#xfce4-volumed-pulse &
#/bin/bash ~/scripts/run-mailsync.sh &
~/scripts/autostart_wait.sh &
