#!/usr/bin/env bash

declare -a fruits=('apple' 'banana' 'pineapple' 'strawberry' 'blueberry')

# access to array variables
echo "${fruits[@]}" #apple banana pineapple strawberry blueberry

# access to array variables using [*] with IFS
echo "${fruits[*]}" #apple banana pineapple strawberry blueberry
