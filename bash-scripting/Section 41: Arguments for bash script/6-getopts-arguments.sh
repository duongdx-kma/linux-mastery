#!/usr/bin/env bash

quiet=1

while getopts 'al:hq' opt; do
    # $OPTARG is option argument
    #echo "${opt} - ${OPTARG}"

    case $opt in
        h)
            what='help'
            break
            ;;
        a) echo "Option a"
            ;;
        l)
            filename=${OPTARG}
            echo "Option l: ${filename}"
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