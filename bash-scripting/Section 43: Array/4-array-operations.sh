#!/usr/bin/env bash

declare -a fruits=('apple' 'banana' 'pineapple' 'strawberry' 'blueberry')

# access to array variables
echo "${fruits[@]}" #apple banana pineapple strawberry blueberry

# get array length
echo "${#fruits[@]}" #5
echo "${#fruits[*]}" #5

# append data to array
fruits+=("grape")
echo "${fruits[@]}" #apple banana pineapple strawberry blueberry grape

# remove element
unset "fruits[2]"
echo "${fruits[@]}" #apple banana strawberry blueberry grape

# array slicing
# (...) mean create new array
sliced_array=("${fruits[@]:1:3}")
echo "${fruits[@]}" #apple banana strawberry blueberry grape
echo "${sliced_array[@]}" #banana strawberry blueberry
