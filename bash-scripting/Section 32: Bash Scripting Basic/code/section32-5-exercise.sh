#!/usr/bin/env bash

# Exercise: Create a system info script!
# Ideas for the script. It could...
# ...print the CPU usage of the last few minutes (uptime)
# ...print the processes that take the most % CPU (ps):
# ...print the % of free disk space of the main drive (df)
# ...print how much memory is available on our system:
# Idea: We can just print out a single line from the file /proc/meminfo
# ...print out if the webserver is running or not:
# Idea: You can pipe the output of systemctl status [unit] into a grep
# ...ping a remote webserver a few times, and print out the whole result

declare -r text_red="$(tput setaf 1)"
declare -r text_green="$(tput setaf 2)"
declare -r text_blue="$(tput setaf 4)"
declare -r text_bold=$(tput bold)
declare -r text_reset=$(tput sgr0)

declare -r line="${text_blue}${text_bold}-----------------------------${text_reset}"

# uptime
echo "${line}"
echo "Getting the system uptime: "
uptime
echo "${line}"

# top 3 processes consume more cpu:
echo "${line}"
echo "top %CPU processes"
ps aux --sort=-pcpu | head -n 4
echo "${line}"

# the % of free disk space of the main drive
echo "${line}"
echo "the % of free disk space of the /dev/sda1 device":
echo "${text_green} $(df -h | grep /dev/sda1 | awk '{print $5}')"
echo "${line}"

# mem-available
echo "${line}"
echo "memory is available on our system:"
grep 'MemAvailable' /proc/meminfo
echo "${line}"

# check nginx status
echo "${line}"
echo "check nginx status:"
systemctl status nginx | grep Active
echo "${line}"

# testing ping
echo "${line}"
echo 'Let'"'"'s test the internet connection:'
ping -c 5 google.com
echo "${line}"