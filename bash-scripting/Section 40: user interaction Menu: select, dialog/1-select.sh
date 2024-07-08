#!/usr/bin/env bash

PS3='Please choose product: '
select product in "Orange" "Apple" "Pineapple"; do
    echo "${REPLY}: ${product}"
done