#!/usr/bin/env bash

# sequence expression
echo "========================================="
echo "sequence expression 1->30"
for number in file.{txt,docx,csv}; do
    echo "${number}"
done

echo "========================================="
for file in file-{a..d}.{txt,docx,csv}; do
    echo "${file}"
    touch "${file}"
done

# checking file:
echo "========================================="
echo "checking txt file file"
for file in *.txt; do
    if [[ -f "${file}" ]]; then
        echo "${file}"
    fi
done
echo "========================================="
echo "checking txt,jpg file"
for file in *.{txt,jpg}; do
    if [[ -f "${file}" ]]; then
        echo "${file}"
    fi
done