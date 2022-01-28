#!/bin/bash
sleep 2
killall -q mpd; mpd &
fcitx &
killall -q utools; utools &
