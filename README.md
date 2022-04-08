# WolClient Linux
 
A /bin/sh script to simplify power on of remote computers while connected via OpenVPN/pfSense VPN.  
This is a stripped down version of [WolClient](https://github.com/frabnet/WolClient) but for Linux users.

## pfSense setup / server side

- Setup OpenVPN Server as you like.
  Hint: providing a DNS Server able to resolve dhcp clients hostnames can simplify things.
- Setup the firewall to allow OpenVPN clients reach pfSense (https) and the remote computer (rdp).
- Create a Wake On Lan user, without a certificate (it's not used in OpenVPN).
- Edit the Wake On Lan user, set "WebCfg - Services: Wake-on-LAN" under "Effective Privileges".

## WolClient setup / client side

- Check if requirements are satisfied. This script relies on:
  - curl
  - grep
- Create/edit `wolclient.config` with required settings:
  - pfSense Hostname
  - pfSense Wake On Lan user
  - pfSense Wake On Lan password  
- Run the script `sh wolclient.sh`
