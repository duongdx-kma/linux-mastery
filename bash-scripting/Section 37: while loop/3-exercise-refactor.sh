#!/usr/bin/env bash

# Can we do this automatically?
# Can we also ignore if a few images can't be found, and keep trying (for up to a few images, like 10 images or so)?

declare -r source_url="https://downloads.codingcoursestv.eu/055%20-%20bash/while/images/image-%%.jpg"
declare -r tex_red="$(tput setaf 1)"
declare -r text_green="$(tput setaf 2)"
declare -r text_blue="$(tput setaf 4)"
declare -r text_bold=$(tput bold)
declare -r text_reset=$(tput sgr0)
declare -r line="${text_blue}${text_bold}========================================${text_reset}"
SCRIPT_DIRECTORY=$(dirname -- "${BASH_SOURCE[0]}")
declare -i start=0

echo -n "Enter your desired number: "
read -r desired_number

while [[ start -lt desired_number ]]; do
    (( start = start + 1 ))
    image_name="image-${start}.jpg"

    echo "${line}"
    if [[ -f ${SCRIPT_DIRECTORY}/${image_name} ]]; then
        echo "the ${text_green}${text_bold}${image_name}${text_reset} already downloaded."
        continue
    fi

    echo "Downloading image: ${image_name}..."
    curl -s "${source_url/\%\%/$start}" -o "${SCRIPT_DIRECTORY}/${image_name}" --fail

    if [[ $? -eq 0 ]]; then
        echo "the ${text_green}${text_bold}${image_name}${text_reset} download completed successfully!"
    else
        echo "the ${tex_red}${text_bold}${image_name}${text_reset} don't exists -> next..."
    fi
done
