#!/usr/bin/env bash

read -p "Enter your desired brand: " brand
declare -A mobiles=(
    ["apple"]="Iphone15 pro max"
    ["samsung"]="s24 ultra"
    ["xiaomi"]="Redmi 9"
    ["google"]="google pixel 9"
)

# mobiles["apple"]="Iphone15 pro max"
# mobiles["samsung"]="s24 ultra"
# mobiles["xiaomi"]="Redmi 9"
# mobiles["google"]="google pixel 9"

# access to array variables
echo "${mobiles[@]}" #apple banana pineapple strawberry blueberry

for key in "${!mobiles[@]}"; do
    echo "${key} - ${mobiles[$key]}"
done

echo "=======================Search data====================="
# check key exist
if [[ -v mobiles[$brand] ]]; then
    echo "the flagship of $brand is: ${mobiles[$brand]}"
else
    echo "the brand '$brand' don't exist"
fi