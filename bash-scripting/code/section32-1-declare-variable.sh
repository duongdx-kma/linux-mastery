#!/usr/bin/env bash

#===================================
# normal delaration
# username="Xuanduong" (same | equivalent)
#===================================
declare username="Xuanduong"

#===================================
# read only variable: -r
#===================================
declare -r user_address="HaNoi-VietNam"
# user_address="DongAnh-HaNoi" # this statement won't be apply

#===================================
# integer variable
#===================================
declare -i user_age=22
# user_age=twentythree # this statement will be error

echo "hello ${username}, have a good day! Are you from ${user_address}, right ? age = ${user_age}"
