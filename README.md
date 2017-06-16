OpenVPN 2FA Automator
=====================

Sick of having to put in a 2fa code to log into vpn? This is the tool for you.

## Install:

On Ubuntu 17.04

```bash
sudo apt install python-pip libzbar-dev screen openvpn;
sudo pip install -r requirements.txt
```

## Howto:

Copy your client.ovpn file into `companyName/client.ovpn`

Copy a screenshot of your qrcode into `companyName/2fa.jpg`

Run like so:

`./login.sh companyName username password`

and off you go!

## Dependencies:
 * Python
 * Bash
 * Screen
 * libzbar
 * OpenVPN (duh)
