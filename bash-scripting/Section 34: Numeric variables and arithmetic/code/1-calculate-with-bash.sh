#!/usr/bin/env bash

x=1
y=5
(( result = x + y))

echo "method 1: x + y = ${result}"
echo "method 2: x + y = $(( x + y ))"


echo "x + y + 2 = $(( x + y + 2 ))"
echo "(x * y) + 2 = $(( (x * y) + 2 ))"

