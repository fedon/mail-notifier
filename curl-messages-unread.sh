#!/bin/bash
# 1 -- google session
# 2 -- gmail label
# 3 -- output file
curl --silent -H "Authorization: Bearer $1" "https://www.googleapis.com/gmail/v1/users/me/messages?labelIds=$2&labelIds=UNREAD" > $3
