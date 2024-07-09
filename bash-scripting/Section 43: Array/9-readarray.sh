#!/usr/bin/env bash

script_directory=$(dirname -- "${BASH_SOURCE[0]}")

ping -c 5 google.com > "${script_directory}/testing.txt"

readarray -t ping_lines < "${script_directory}/testing.txt"

echo "==========================================="
echo "testing file contents"
echo "${ping_lines[@]}"
echo "${ping_lines[1]}"
echo "==========================================="
echo "testing file contents  with for statements"
for line in "${ping_lines[@]}"; do
    echo "${line}"
done

echo '###########################################'

echo "==========================================="
# -s 1: meaning skip 1 line
# -n 3: meaning read  only 3 line
# -t: don't break to new line
readarray -s 1 -n 3 -t ping_lines2 < <(ping -c 5 google.com)

echo "testing file contents"
echo "${ping_lines2[@]}"
echo "${ping_lines2[1]}"

echo "==========================================="
echo "testing file contents  with for statements"
for line in "${ping_lines2[@]}"; do
    echo "${line}"
done
