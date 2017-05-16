#!/bin/bash
echo $@;
screenName='openvpn-'$1
clientFile=$1'/client.ovpn'
echo $screenName
echo $clientFile;

if ! screen -list | grep -q "$screenName"; then
    screen -d -m -S $screenName sudo openvpn $clientFile;
else
    screen -S $screenName -p 0 -X sudo openvpn $clientFile"^M"
fi
sleep 2;
screen -S $screenName -p 0 -X stuff $2"^M"
sleep 2;
screen -S $screenName -p 0 -X stuff $3"^M"
sleep 2;
screen -S $screenName -p 0 -X stuff "`echo 2fa.txt`^M"
