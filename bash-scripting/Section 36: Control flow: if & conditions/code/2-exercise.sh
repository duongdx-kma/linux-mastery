#!/usr/bin/env bash

# Downloads the eBook file - but only when needed!
# And then, calculates how many lines contain the word "love" at least 1 time
# Also:
# It should print error messages to stderr
# It should exit with the correct exit code on error

declare -i download=0


if [[ -f "romeo.txt" ]]; then
    download=1
    echo "File romeo.txt already exists, skipping download"
else
    echo 'Downloading the file (romeo and juliet)...'
    curl -s https://downloads.codingcoursestv.eu/055%20-%20bash/if/romeo.txt -o romeo.txt
fi

if [[ $? -eq 0 && download -eq 0 ]]; then
    echo 'Download completed successfully'

elif [[ ( ! $? -eq 0 ) && download -eq 0 ]]; then
    echo 'Download Failed' >&2
    exit 1;
fi

# num_lines=$(grep 'love' romeo.txt | wc -l)
num_lines=$(grep -c 'love' romeo.txt)

echo "The word 'love' is can be found in ${num_lines} lines."
