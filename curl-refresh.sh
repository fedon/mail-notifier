#!/bin/bash
# 1 -- client id
# 2 -- secret
# 3 -- refresh key
curl --silent -d "client_id=$1&client_secret=$2&grant_type=refresh_token&refresh_token=$3" https://accounts.google.com/o/oauth2/token | tr ":" " " | awk ' /access_token/ {print $2}' | tr -d \" | tr -d ,
