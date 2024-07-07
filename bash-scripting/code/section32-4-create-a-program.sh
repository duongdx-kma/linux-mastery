#!/usr/bin/env bash

# $(tput setaf 2)$(tput bold)text$(tput sgr0)

declare -r text_green="$(tput setaf 2)"
declare -r text_bold=$(tput bold)
declare -r text_reset=$(tput sgr0)

read -p read -p "Enter your  username: " username

echo "hello ${text_green}${text_bold}${username}${text_reset}, have a good day!"
