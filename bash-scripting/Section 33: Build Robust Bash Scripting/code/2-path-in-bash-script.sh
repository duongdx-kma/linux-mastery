#!/usr/bin/env bash

declare -r text_red="$(tput setaf 1)"
declare -r text_green="$(tput setaf 2)"
declare -r text_blue="$(tput setaf 4)"
declare -r text_bold=$(tput bold)
declare -r text_reset=$(tput sgr0)

declare -r line="${text_blue}-----------------------------${text_reset}"

echo "${line}"
echo "Bash_source[0] here:"
echo "${BASH_SOURCE[0]}"
echo "${line}"

SCRIPT_DIRECTORY=$(dirname -- "${BASH_SOURCE[0]}")

echo "${line}"
echo "SCRIPT_DIRECTORY here"
echo "${SCRIPT_DIRECTORY}"
echo "${line}"

echo "${line}"
echo "list up folder"
ls "${SCRIPT_DIRECTORY}"
echo "${line}"
