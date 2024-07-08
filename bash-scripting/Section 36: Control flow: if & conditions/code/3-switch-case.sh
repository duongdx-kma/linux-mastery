#!/usr/bin/env bash

echo -n "Enter your Os: "
read -r distribution

case $distribution in
    "Mac")
        echo "On Mac os, you are rick kid ~.~"
    ;;
    "Ubuntu")
        echo "On Ubuntu os, you are developer </>"
    ;;
    "Window")
        echo "On Window os, you are normal user ~~~"
    ;;
    *)
        echo "default case..."
    ;;
esac

weather='Cloudy'

case "$weather" in
    "Sunny")
        echo -n "It's a beautiful day for outdoor activities." ;&
    "Cloudy")
        echo -n "The weather is moderate and pleasant." ;&
    "Rainy")
        echo -n "Don't forget your umbrella today!" ;;
esac
