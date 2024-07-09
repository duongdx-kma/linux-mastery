#!/usr/bin/env bash

declare -a fruits=('apple' 'banana' 'pineapple' 'strawberry' 'blueberry')

# access to array variables
echo "${fruits[@]}" #apple banana pineapple strawberry blueberry


# copy 2
copy_fruits_2=("mango" "${fruits[@]}" "papaya")
echo "${copy_fruits_2[@]}" #mango apple banana pineapple strawberry blueberry papaya
echo "${copy_fruits_2[1]}" #apple

for fruit in "${copy_fruits_2[@]}"; do
    echo "- ${fruit}"
done

select fruit in "${copy_fruits_2[@]}"; do
    echo "- ${fruit}"
done