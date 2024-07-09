#!/usr/bin/env bash

# Your exercise:
# - Create a program (bash-file), that asks the user to enter the name of a city ("London", "New York",...)
# - It should then send a request to my weather API, to fetch the current temperature
# - This temperature is in °C. Depending on your preferences, you might want to convert it to °F - for example with the program "bc".
# - Important, before you start:
# - We might have to use additional parameters for curl...
# - -G --data-urlencode 'city=New York'

# define variables
declare -r api_url="https://downloads.codingcoursestv.eu/055%20-%20bash/api/api.php"
declare -r text_red="$(tput setaf 1)"
declare -r text_green="$(tput setaf 2)"
declare -r text_yellow="$(tput setaf 3)"
declare -r text_blue="$(tput setaf 4)"
declare -r text_bold=$(tput bold)
declare -r text_reset=$(tput sgr0)
declare -r line="${text_blue}${text_bold}========================================${text_reset}"

echo -n "Enter your city: "
read city

weather_data=$(curl -s  "${api_url}" -G --data-urlencode city="${city}" --data-urlencode 'testing_key=testing')
temperature=$(echo "${weather_data}" | jq '.temperature')

echo "${line}"
echo "Weather data is:"
echo "${weather_data}" | jq

# formula: fahrenheit = celsius * (9 / 5) + 32
fahrenheit=$(echo "scale=2; $temperature * (9 / 5) + 32" | bc)

if [[ $temperature -gt 25 ]]; then
    text_temperature=$text_yellow
elif [[ $temperature -gt 30 ]]; then
    text_temperature=$text_red
else
    text_temperature=$text_green
fi

echo "In ${city}, the current temperature is: ${text_temperature}${temperature}${text_reset} °C"
echo "In ${city}, the current temperature is: ${text_temperature}${fahrenheit}${text_reset} °F"

echo "${line}"
