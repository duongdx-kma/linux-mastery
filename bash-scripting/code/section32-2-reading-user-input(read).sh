#!/usr/bin/env bash

# create variable and read user input data:

read -p "Enter username: " username

# remove specific character: `-d`
# testing: enter 'HaNoi-VietNam...' => 'HaNoi-VietNam'
read -p "Enter address: " -d '.' address

# do not echo input coming from a terminal: `-s`
read -p "Enter password: " -s password

read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

echo "hello ${username} - ${password} - ${address}, have a good day!"
