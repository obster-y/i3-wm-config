#!/usr/bin/env bash

# Terminate any currently running instances
killall -q polybar

# Pause while killall completes
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

if type "xrandr" > /dev/null; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload mybar -c ~/.config/i3/polybar/config &
  done
else
  polybar --reload mybar -c ~/.config/i3/polybar/config &
fi

echo "polybars launched..."
