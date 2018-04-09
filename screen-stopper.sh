#!/bin/bash
screenName='openvpn-'$1
screen -S $screenName -X quit

