#!/usr/bin/env bash

PS3='Please choose your option: '
select option in "uptime" "user" "free diskspace" "quit"; do
    # echo "${REPLY}: ${option}"

    case "${option}" in
        "uptime")
            uptime
            ;;
        "user")
            echo "${USER}"
            ;;

        "free diskspace")
            free -mh
            ;;
        "quit")
            break
            ;;
        *)
            echo "Option not found" >&2
            ;;
    esac
done