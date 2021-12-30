#!/bin/bash

#xrandr --auto --output DP-2 --same-as eDP-1 --size 1920x1080
#xrandr --auto --output HDMI-1  --right-of eDP-1 --size 1920x1080
xrandr --auto --output eDP-1 --pos 0x0 --mode 1920x1080 --primary --output HDMI-1-0 --mode 1920x1080 --left-of eDP-1
