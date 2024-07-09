#!/usr/bin/env bash


declare text_red
declare text_green
declare text_bold
declare text_reset

text_red="$(tput setaf 1)"
text_green="$(tput setaf 2)"
text_bold=$(tput bold)
text_reset=$(tput sgr0)

# folders=(
#     "${HOME}/Desktop"
#     "${HOME}/Downloads"
#     "${HOME}/Documents"
#     "${HOME}/Documents2"
#     "${HOME}/Documents3"
# )

# ./12-calculate-folder-size.sh ~/Desktop ~/Downloads ~/Documents
# reading all args passed to script file
declare -a folders
declare -i threshold=500

while getopts 'd:' option 2>/dev/null; do
    # echo "${option} - ${OPTARG}"

    case $option in
        d)
            folders+=("${OPTARG}")
            ;;
        *) continue
            ;;
    esac
done

if [[ "${#folders[@]}" -eq 0 ]]; then
    echo "No folders have been provided with option -d"
    exit 1
fi

for folder in "${folders[@]}"; do
    if [[ ! -d "${folder}" ]]; then
        continue
    fi

    read -r size rest < <(du -sm "${folder}")

    if (( size >= threshold )); then
        text_color="${text_red}"
    else
        text_color="${text_green}"
    fi

    echo "${rest} size: ${text_color}${text_bold}${size}${text_reset}MB."
done
