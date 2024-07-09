#!/usr/bin/env bash

declare -a fruits=('apple' 'banana' 'pineapple' 'strawberry' 'blueberry')
declare found

# access to array variables
echo "${fruits[@]}" #apple banana pineapple strawberry blueberry

read -p "Enter your desired value: " search_for

for index in "${!fruits[@]}"; do
    if [[ "${fruits[$index]}" == "${search_for}" ]]; then
        found=$index
        break
    fi
done

if [[ -n $found ]]; then
    echo "The ${search_for} position is: ${found}"
else
    echo "The item not found !"
fi