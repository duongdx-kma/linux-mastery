#!/usr/bin/env bash

# method_1:
device_data() {
    local a=${1:-"0"}
    local b=${2:-"0"}

    result="$(echo "scale=2; $a / $b" | bc)"
    return 0
}

# method_2:
device_data_2() {
    local a=${1:-"0"}
    local b=${2:-"0"}
    local device_result
    device_result="$(echo "scale=2; $a / $b" | bc)"

    if [[ $device_result == .* ]]; then
        device_result="0$device_result"
    fi
    echo "$device_result"
    return 0
}


# testing method 1
echo "-----------------------"
device_data 5 10
echo "${result}"

# testing method 2
echo "-----------------------"
data=$(device_data_2 4 8)

echo "4/8 = ${data}"
echo "${device_result}" # => null, because device_result is local variable