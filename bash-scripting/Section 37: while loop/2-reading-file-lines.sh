#!/usr/bin/env bash

declare -r file_name='students.csv'
declare -r tex_red="$(tput setaf 1)"
declare -r text_green="$(tput setaf 2)"
declare -r text_blue="$(tput setaf 4)"
declare -r text_bold=$(tput bold)
declare -r text_reset=$(tput sgr0)
declare -r line="${text_blue}${text_bold}========================================${text_reset}"
SCRIPT_DIRECTORY=$(dirname -- "${BASH_SOURCE[0]}")

while IFS=, read -r id name nationality city other; do
    echo "${line}"
    echo "Student ID: ${tex_red}${id}${text_reset}"
    echo "Student name: ${text_green}${name}${text_reset}"
    echo "Student nationality: ${nationality}"
    echo "Student city: ${city}"
done < <(tail -n +2 "${SCRIPT_DIRECTORY}/${file_name}") # ignore the header