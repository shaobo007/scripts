#!/bin/bash
if test -z "$(pgrep clash)"; then
    cd ~/Tools/clash ;
    ./clash -d .
else
    kill $(pgrep clash)
fi

