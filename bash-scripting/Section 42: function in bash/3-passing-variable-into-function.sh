#!/usr/bin/env bash

echo "---"

# method_1:
greeting_1() {
    read username
    case "${language}" in
        vi)
            echo "Xin chào ${username}! chúc bạn ngày mới tốt lành"
            ;;
        fr)
            echo "Bonjour ${username}"
            ;;
        jp)
            echo "こんにちは ${username}"
            ;;
        *)
            echo "hello ${username}! have a good day"
            ;;
        esac
}

# method_2:
greeting_2() {
    # provide default values for variable
    local name=${1:-"Pop"}
    echo "hello ${name}! have a good day"
}

echo -n "please enter your language: "
read -r language

# testing greeting_1 function
echo "Alice" | greeting_1

# testing greeting_2 function
greeting_2
greeting_2 "Alice"