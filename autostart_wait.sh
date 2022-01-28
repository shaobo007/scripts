#!/bin/bash
sleep 2
killall -q mpd; mpd &
killall -q fcitx; fcitx &
killall -q utools; utools &
