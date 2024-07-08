#!/usr/bin/env bash
# sequence expression
echo "========================================="
echo "sequence expression 1->30"
for number in {1..30}; do
    echo "${number}"
done

# sequence expression
echo "========================================="
echo "sequence expression a->Z"
for string in {A..z}; do
    echo "${string}"
done


# sequence expression
echo "========================================="
echo "sequence expression 1->30"
for number in file-{1..30}.txt; do
    echo "${number}"
done