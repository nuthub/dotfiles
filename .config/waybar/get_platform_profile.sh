#!/bin/sh

state=$(cat /sys/firmware/acpi/platform_profile)
output=$state

if [ $state == "low-power" ]; then
    output="Lmh"
elif [ $state == "balanced" ]; then
    output="lMh"
elif [ $state == "performance" ]; then
    output="lmH"
fi

echo $output
