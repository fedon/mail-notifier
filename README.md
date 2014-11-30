mail-notifier
=============

Usb mail notifier script for gmail

I. Introduction
Network calls are made by curl.
Tested on Linux Fedora.
Why to publish? First of all that is how open source works. I use this <a href="https://github.com/vogelchr/led-notify-module">module</a> to control my notifier device and this repo is my pay back.
Another thing is gmail API is not so easy to start with as it may seem. Although, google has abundant documentation it is ill structured. There are lots of versions and when you read something it is not clear if it is the latest/actual version.

II. Gmail credentials
For this script to work some Gmail credentials are required. Those are
- client Id;
- client secret;
- refresh token.
I have tested it for "installed application" type. Step by step <a href="https://developers.google.com/accounts/docs/OAuth2InstalledApp">instructions</a> I have used.
  a) Be careful with scope. I use "scope=https://www.googleapis.com/auth/gmail.readonly". First of all if you play with scopes be aware their additivity is not trivial. So, if you want to change the scope you better to revoke previous permission first and reinit it from the very beginning.
  b) Even so, I have read-only permission I consider it to be a security risk. This far I use ssh key to encript and decript my cridentials. See comments in line. At the end of the day it is on you to decide which security strategy to follow.
III. Usb device
The last thing is to provide your notifier device path in color On/Off scripts. It should look similar to "6-2\:1.0".

IV. Run
cd to directory with check-mail.sh and run it with
# ./check-mail.sh

You will be asked for ssh key pass three times if any. And one time your password for sudo. This means you have to be a valid sudoer.

Known issue
After notebook sleep-resume the device is gone. I guess it is something with udev. It will be the next step. Work-around replug the device.
