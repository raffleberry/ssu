#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "USAGE: $0 <path-to-output-file>"
    exit -1
fi

output_file=$1

max_cycles=1000

check_max_cycle() {
    cur=$1
    if [[ $cycle -ge $max_cycles ]]; then

        echo "1000+ cycles already created. Please archive them."
        exit 1
    fi
}

cycle=0

# script keeps running
for (( ; cycle < max_cycles; cycle++))
do
    if [[ ! -e "$output_file.$cycle" ]]; then
        break
    fi
done

check_max_cycle $cycle

echo "Cycle: $cycle, output_file: $output_file.$cycle"

prev_state=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state" | sed 's/ //g' | cut -d':' -f2)

for (( ; ; ))
do
    echo "------"
    # 69
    percent=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "percentage" | cut -d':' -f2 | sed 's/ \|%//g')

    if [[ -n "$state" ]]; then
        prev_state="$state"
    fi

    # discharging/not discharging :)
    state=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state" | sed 's/ //g' | cut -d':' -f2)
    
    echo "prev_state: $prev_state , state: $state"

    # iso 8601
    timestamp=$(date -u +%Y-%m-%dT%H:%M:%S%Z)

    # new cycle new output file
    if [[ $prev_state == "discharging" && $state != "discharging" ]]; then
        cycle=$(($cycle+1))
        check_max_cycle $cycle

        echo "action: new cycle - $cycle"
    elif [[ $prev_state == "discharging" && $state == "discharging" ]]; then
        echo "$timestamp,$state,$percent" >> "$output_file.$cycle"

        echo "action: writing - $timestamp,$state,$percent"
    else

        echo "action: none"
    fi

    sleep 60
done


