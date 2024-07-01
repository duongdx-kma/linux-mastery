#!/bin/sh

#/usr/local/bin/ping_and_log.sh
/bin/date '+%Y-%m-%d %T' >> /var/log/ping.txt
/bin/ping -c 4 google.com >> /var/log/ping.txt
