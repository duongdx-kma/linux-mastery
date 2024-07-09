#!/usr/bin/env bash

i=1
echo "The argument values without shift command:"
#Iterate all values using for loop
for value in "$@"; do
    echo "Argument no. $i = $value"
    ((i++))
done

while (( $# != 0 )); do
    echo "- $1"
    shift
done