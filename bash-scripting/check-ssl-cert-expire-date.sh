#!/bin/bash

# Based on https://askubuntu.com/questions/1198619/bash-script-to-calculate-remaining-days-to-expire-ssl-certs-in-a-website

### Read Site Certificate and save as File ###
echo -n | openssl s_client -servername $1 -connect $1:443 2>/dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > $1.crt


### Get Full Expiratoin Date ###
date=$(openssl x509 -in $1.crt -enddate -noout | sed "s/.*=\(.*\)/\1/" | awk -F " " '{print $1,$2,$3,$4}')

### Convert Expiration Date in Epoch Format ###
date_s=$(date -j -f "%b %d %T %Y" "$date" "+%s")

### Get Curent Date in Epoch Format ###
now_s=$(date +%s)

### Calculate Time Difference ###
date_diff=$(( (date_s - now_s) / 86400 ))

echo "Certificate for $1 will expire in $date_diff days"
