#!/usr/bin/env bash

quiet=1

while getopts 'alhq' opt 2>/dev/null; do
    case $opt in
        h)
            what='help'
            break
            ;;
        a) echo "Option a"
            ;;
        l) echo "Option l"
            ;;
        q) quiet=0
            ;;
        ?) echo "An error occurred"
            ;&
    esac
done

if [[ $what == 'help' ]]; then
    echo "This is help menu"
    echo "-a: bla bla"
    echo "-l: blo blo"
    echo "-c: ble ble"
fi

if [[ quiet -eq 1 && -z $what ]]; then
    echo "the uptime is $(uptime)"
fi