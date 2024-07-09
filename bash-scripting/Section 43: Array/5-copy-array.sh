#!/usr/bin/env bash

declare -a fruits=('apple' 'banana' 'pineapple' 'strawberry' 'blueberry')

# access to array variables
echo "${fruits[@]}" #apple banana pineapple strawberry blueberry

# (...) mean create new array
# ${...}: This is just a way to access a variable
# [@]: We want to get all individual elements of the array as individual elements
copy_fruits=("${fruits[@]}")
echo "${copy_fruits[@]}" #apple banana pineapple strawberry blueberry
echo "${copy_fruits[1]}" #banana

# copy 2
copy_fruits_2=("mango" "${fruits[@]}" "papaya")
echo "${copy_fruits_2[@]}" #mango apple banana pineapple strawberry blueberry papaya
echo "${copy_fruits_2[1]}" #apple