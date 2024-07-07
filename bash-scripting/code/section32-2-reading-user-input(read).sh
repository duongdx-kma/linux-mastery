#!/usr/bin/env bash

# create variable and read user input data:
read -p "Enter username: " username

# The input will be split into 2 segments:
# first word: -> first_name
# all the remaining words: -> last_name
# In Bash, the variable `IFS` controls how whitespace is being handled by certain commands
# space, tab, newline
# IFS=$' \t\n'
read -p "Enter your full name: " first_name last_name

# remove specific character: `-d`
# continue until the first character of DELIM is read, rather than newline
read -p "Enter address: " -d '.' address

# do not echo input coming from a terminal: `-s`
read -p "Enter password: " -s password

read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

echo "hello ${username} - ${password} - ${address}, have a good day!"
