#!/bin/bash

set -e

if [[ `whoami` != "root" ]]; then
  echo "This script must be run by root!" 1>&2
  exit 2
fi

if [ ! -d config ]; then
  echo "Can't find my config/ directory in the current directory!" 1>&2
  echo "Are you running me from the server-setup module's directory?" 1>&2
  exit 1
fi

echo "WARNING: this script will disable password login via ssh!" 1>&2
echo "Unless you have added your public key to the ~/.ssh/authorized_keys file," 1>&2
echo "you will be unable to log in to this machine!" 1>&2
echo "SSH logins as root will also be disabled." 1>&2
printf "Continue? [y/N]: "
read ack
if [[ ! "$ack" =~ ^ye*s*[\ \\t\\n]*$ ]]; then
  echo "Aborting..." 1>&2
  exit
fi


## almost always a good idea
apt-get update

## install utilities
apt-get install -yy --no-install-recommends htop screen tmux tree git-core

## install iptables
apt-get install -yy --no-install-recommends iptables-persistent

## create new iptables rule chain from scratch so it works even if user saves the existing iptables rules
## only allows connections on ports 22, 80, 443, 8080, and 8443
## ports 80 and 443 are redirected to 8080 and 8443, respectively
iptables -P INPUT ACCEPT
iptables -F
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
iptables -A INPUT -p tcp --dport 8443 -j ACCEPT
iptables -A PREROUTING -t nat -p tcp --dport 80 -j REDIRECT --to-port 8080
iptables -A PREROUTING -t nat -p tcp --dport 443 -j REDIRECT --to-port 8443
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
/etc/init.d/iptables-persistent save
/etc/init.d/iptables-persistent restart

## install fail2ban
apt-get install -yy --no-install-recommends fail2ban

mv /etc/ssh/sshd_config /etc/ssh/sshd_config.default
ln -sf `pwd`/config/etc/ssh/sshd_config /etc/ssh/sshd_config
/etc/init.d/ssh restart
