#!/bin/sh

# Terminate already running bar instances
pkill polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar for primary display
for m in $(xrandr --query | grep " connected" | grep "primary" | cut -d" " -f1); do
    echo "panel started for primary $m"
    MONITOR=$m polybar --reload panel-primary &
done

for m in $(xrandr --query | grep " connected" | grep -v "primary" | cut -d" " -f1); do
    echo "no panel started for non-primary $m"
#    MONITOR=$m polybar --reload panel-secondary &
done

echo "Bar(s) launched..."
