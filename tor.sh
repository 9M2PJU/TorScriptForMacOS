#!/usr/bin/env bash
#
# https://kremalicious.com/simple-tor-setup-on-mac-os-x/
# http://leonid.shevtsov.me/post/an-easy-way-to-use-tor-on-os-x/
#


# Choose from 'Wi-Fi' or 'Ethernet' or 'Display Ethernet'
INTERFACE=Wi-Fi

# Prompt for superuser password
sudo -v

# Keep-alive: update existing `sudo` time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# trap ctrl-c and call disable_proxy()
function disable_proxy() {
    sudo networksetup -setsocksfirewallproxystate $INTERFACE off
    echo "$(tput setaf 64)" #green
    echo "SOCKS proxy disabled."
    echo "$(tput sgr0)" # color reset
}
trap disable_proxy INT

# Setting up socks
sudo networksetup -setsocksfirewallproxy $INTERFACE 127.0.0.1 9050 off
sudo networksetup -setsocksfirewallproxystate $INTERFACE on

echo "$(tput setaf 64)" # green
echo "SOCKS proxy 127.0.0.1:9050 enabled."
echo "$(tput setaf 136)" # orange
echo "Starting Tor..."
echo "$(tput sgr0)" # color reset

tor
