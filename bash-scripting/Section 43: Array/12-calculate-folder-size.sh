#!/usr/bin/env bash


declare -r text_red="$(tput setaf 1)"
declare -r text_green="$(tput setaf 2)"
declare -r text_bold=$(tput bold)
declare -r text_reset=$(tput sgr0)

# folders=(
#     "${HOME}/Desktop"
#     "${HOME}/Downloads"
#     "${HOME}/Documents"
#     "${HOME}/Documents2"
#     "${HOME}/Documents3"
# )

# ./12-calculate-folder-size.sh ~/Desktop ~/Downloads ~/Documents
# reading all args passed to script file
folders=("$@")

threshold=500

for folder in "${folders[@]}"; do
    if [[ ! -d "${folder}" ]]; then
        continue
    fi

    read size rest < <(du -sm "${folder}")

    if (( size >= threshold )); then
        text_color="${text_red}"
    else
        text_color="${text_green}"
    fi

    echo "${rest} size: ${text_color}${text_bold}${size}${text_reset}MB."
done
