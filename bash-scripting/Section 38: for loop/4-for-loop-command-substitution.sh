#!/usr/bin/env bash

# sequence expression
echo "========================================="
echo "uptime"
for word in $(uptime); do
    echo "${word}"
done


# sequence program
start=10
end=20

echo "========================================="
echo "sequence program"
for index in $(seq $start $end); do
    echo "${index}"
done

echo "========================================="
echo "data from file"
SCRIPT_DIRECTORY=$(dirname -- "${BASH_SOURCE[0]}")
IFS=$'\n'; for name in $(cat "${SCRIPT_DIRECTORY}/testing.txt"); do
    echo "${name}"
done