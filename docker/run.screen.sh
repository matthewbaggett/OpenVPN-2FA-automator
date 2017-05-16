#!/usr/bin/env bash
screenName='openvpn-'$VPN_CONFIG;
echo "Creating screen $screenName ... ";
(screen -m -S $screenName) &
echo "Screen Created..." &
sleep 86400;
