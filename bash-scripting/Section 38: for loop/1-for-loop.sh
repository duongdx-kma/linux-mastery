#!/usr/bin/env bash

for name in "Duong DX" "Duong Dx2"; do
    echo "${name}"
done

echo "========================================="
echo "testing number"
for number in 1 2 3 4 5 6; do
    echo "${number}"
    if (( number == 3 )); then
        continue
    fi
done

# sequence expression
echo "========================================="
echo "sequence expression 1->30"
for number in {1..30}; do
    echo "${number}"
done

# sequence expression
echo "========================================="
echo "sequence expression a->Z"
for string in {A..z}; do
    echo "${string}"
done


echo "========================================="
echo "data from file"
SCRIPT_DIRECTORY=$(dirname -- "${BASH_SOURCE[0]}")
IFS=$'\n'; for name in $(cat "${SCRIPT_DIRECTORY}/testing.txt"); do
    echo "${name}"
done
