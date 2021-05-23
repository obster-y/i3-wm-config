#!/bin/bash

f=$(xrandr | grep -c 'HDMI-0 connected')

if [ $f = "1" ]
then xrandr --output DP-0 --primary --mode 3840x2160 --pos 0x0 --rotate normal \
--output HDMI-0 --mode 1920x1080 --pos 3840x120 --rotate right \
--output DP-2 --mode 1920x1080 --pos 4920x487 --rotate normal \
--output DP-1 --off \
--output DP-3 --off \
--output DP-4 --off
fi
