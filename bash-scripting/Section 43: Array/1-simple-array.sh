#!/usr/bin/env bash

declare -a fruits=('apple' 'banana' 'pineapple')

echo "${fruits}" #apple
echo "${fruits[0]}" #apple
echo "${fruits[1]}" #banana
echo "${fruits[-1]}" #pineapple