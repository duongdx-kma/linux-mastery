#!/usr/bin/env bash

# ./7-output-of-program-to-array.sh < <(echo apple google xiaomi huawei)
# echo apple google xiaomi huawei | ./7-output-of-program-to-array.sh
echo -n "Please enter some brands: "
read -a brands
# read -p "Please enter some brands: " -a brands

echo "-----------------------------"
echo "List up brands:"
echo "${brands[@]}"

echo "-----------------------------"
echo "${brands}"
echo "${brands[1]}"

# Preferred
# get data from (uptime) program
read -a uptime_array < <(uptime)
echo "------------uptime-----------------"
echo "${uptime_array}"
echo "${uptime_array[1]}"

# at least preferred (avoid)
uptime_data_not_preferred=( $(uptime) )
echo "${uptime_data_not_preferred}"
echo "${uptime_data_not_preferred[1]}"