#!/usr/bin/env bash

echo "5 + 6" | bc # 11

echo "5.3 + 6+1" | bc # 11.4

echo "15 / 13" | bc # 1

echo "scale=4; 15 / 13" | bc # 1.1538

number=25

echo "scale=4; ${number} / 13" | bc #1.9230
