#!/bin/bash

# Following variables may be a security risk if compromized. Use proper encription to protect your privacy.
# For instance, xxx=`openssl rsautl -decrypt -inkey ~/.ssh/id_rsa -in xxx.enc`
# see google for available encription tools.
rfkey=<refresh token>
secret=<client secret>
clientid=<client Id>

session=xxx
echo Start polling gmail

primary=CATEGORY_PERSONAL # red
social=CATEGORY_SOCIAL    # blue
promo=CATEGORY_PROMOTIONS # green 

resp=response.txt  # convenience response storage file
errCount=0

while [ $errCount -lt 2 ]; do
# check primary label
./curl-messages-unread.sh $session $primary $resp

grep "code.*4[[:digit:]]\{2\}" $resp > /dev/null # check response code
status=$?
if [ $status -ne 0 ]; then # session is OK
  errCount=0
  cat $resp | tr ":" " " | sudo awk ' /resultSizeEstimate/ {if ($2+0 > 0) system("./colourOn.sh red"); else system("./colourOff.sh red");fi}'; 
else # response status 4xx refresh session is required
  errCount=$((errCount+1))
  echo Call refresh;
  session=`./curl-refresh.sh $clientid $secret $rfkey`
fi;

# check social label
./curl-messages-unread.sh $session $social $resp

grep "code.*4[[:digit:]]\{2\}" $resp > /dev/null # check response code
status=$?
if [ $status -ne 0 ]; then # session is OK
  errCount=0
  cat $resp | tr ":" " " | sudo awk ' /resultSizeEstimate/ {if ($2+0 > 0) system("./colourOn.sh blue"); else system("./colourOff.sh blue");fi}'; 
else # response status 4xx refresh session is required
  errCount=$((errCount+1))
  echo Call refresh;
  session=`./curl-refresh.sh $clientid $secret $rfkey`
fi;

# check promo label
./curl-messages-unread.sh $session $promo $resp

grep "code.*4[[:digit:]]\{2\}" $resp > /dev/null # check response code
status=$?
if [ $status -ne 0 ]; then # session is OK
  errCount=0
  cat $resp | tr ":" " " | sudo awk ' /resultSizeEstimate/ {if ($2+0 > 0) system("./colourOn.sh green"); else system("./colourOff.sh green");fi}'; 
else # response status 4xx refresh session is required
  errCount=$((errCount+1))
  echo Call refresh;
  session=`./curl-refresh.sh $clientid $secret $rfkey`
fi;
sleep 10
done
# blink on exit
sudo ./blueOn.sh
sudo ./greenOn.sh
sudo ./redOn.sh
sudo ./blueOff.sh
sudo ./greenOff.sh
sudo ./redOff.sh
echo Refresh failed. Exiting
