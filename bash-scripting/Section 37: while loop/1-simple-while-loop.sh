#!/usr/bin/env bash

echo -n "Enter your desired number: "
read count

while [[ $count -le 10 ]]; do
    echo "greet! ${count}"
    (( count = count + 1 ))
done