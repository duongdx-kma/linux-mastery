#!/usr/bin/env bash

echo -n "Please enter an integer: "
read value


# //: mean remove all character in []
# [^0-9]: mean negates all character difference 0-9
# /: replace all of those character to ''
# for example: /c: replace all of those character to ''
echo "${value//[^0-9]/}"

declare -i integer_var="${value//[^0-9]/}"

echo "$integer_var"