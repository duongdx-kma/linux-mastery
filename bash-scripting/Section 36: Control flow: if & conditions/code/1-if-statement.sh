#!/usr/bin/env bash

echo -n "Enter your number: "
read number

if [[ $number -gt 25 ]]; then
    echo "Your enter number greater than 25"
else
    echo "Your enter number less than 25"
fi
