#!/usr/bin/env bash

declare -a fruits=('apple' 'banana' 'pineapple' 'strawberry' 'blueberry')

# access to array variables
echo "${fruits[@]}" #apple banana pineapple strawberry blueberry

# override
fruits[1]="banana1"
echo "${fruits[@]}" #apple banana1 pineapple strawberry blueberry

fruits[-1]="blueberry22"
echo "${fruits[@]}" #apple banana1 pineapple strawberry blueberry22