#!/usr/bin/env bash
screenName='openvpn-'$VPN_CONFIG;
screen -d -m -S $screenName;
sleep 86400;
