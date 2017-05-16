#!/bin/bash
echo "Screen Starter: ${0%/*}"
cd "${0%/*}"

screenName='openvpn-'$1
clientFile=$1'/client.ovpn'
screen -list | grep -q "$screenName"
echo "Client File: $clientFile"
if ! screen -list | grep -q "$screenName"; then
    echo "creating screen $screenName";
    screen -d -m -S $screenName -l screen.log sh -c 'sudo openvpn $clientFile; exec bash';
else
    echo "resuming screen $screenName";
    screen -S $screenName -p 0 -X stuff "sudo openvpn $clientFile^M"
fi
sleep 2;
echo "Sending username $2";
screen -list
ps -ef | grep screen | grep pty
screen -S $screenName -p 0 -X stuff $2"^M"
sleep 2;
screen -list
ps -ef | grep screen | grep pty
echo "Sending password $3";
screen -S $screenName -p 0 -X stuff $3"^M"
sleep 2;
screen -list
ps -ef | grep screen | grep pty
echo "Sending 2fa $4";
screen -S $screenName -p 0 -X stuff $4"^M"
cd -;