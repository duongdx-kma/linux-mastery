#!/usr/bin/env bash

declare -i integer_var

x=14
integer_var=15

echo "$(( integer_var + z))" # =  15 (because integer_var is integer then z=0)
echo "$(( integer_var + x))" # =  29

integer_var=$(( 15 + x))
(( integer_var = 15 * x ))

echo $integer_var