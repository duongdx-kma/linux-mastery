#!/usr/bin/env bash

echo "---"

greeting() {
    # by default variable in bash is `global variable`
    # => declare local variable
    local username

    if [[ -z "$username" ]]; then
        read -p "please enter your name: " username
    fi

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

echo -n "please enter your language: "
read -r language

greeting
greeting
greeting