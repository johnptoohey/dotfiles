#!/bin/bash

if [[ `whoami` != 'root' ]]; then
  echo "This script must be run by root!" 1>&2
  echo "Add 'sudo' and try again." 1>&2
  exit 1
fi

# This file will check to see if you have fuse and device-mapper support in your kernel, either
# builtin or available in modules.
# Without these modules, TrueCrypt will not be able to mount volumes, rendering it basically
# useless.

# First we'll check for fuse
fuse_report=`modprobe -v fuse 2>&1`
fuse_exit=$?
if [[ $fuse_exit != 0 ]]; then
  echo "Uh-oh! It looks like you don't have fuse support in your kernel and no fuse" 1>&2
  echo "module is available." 1>&2
  echo "" 1>&2
  echo "Make sure you're using official Debian or Ubuntu AMIs, or the Linode-provided" 1>&2
  echo "distribution images." 1>&2
  exit 2
fi

# If our modprobe command caused the fuse module to be loaded, then we need to add a line to
# /etc/modules so the module will be loaded on boot.
if [[ $fuse_report =~ 'insmod' ]]; then
  echo 'fuse' >> /etc/modules
fi

# Then we'll check for device-mapper
dm_report=`modprobe -v dm_mod 2>&1`
dm_exit=$?
if [[ $dm_exit != 0 ]]; then
  grepped=`zgrep -i blk_dev_dm=y /proc/config.gz`
  if [ -z "$grepped" ]; then
    echo "Uh-oh! It looks like you don't have device-mapper support in your kernel and no" 1>&2
    echo "device-mapper module is available." 1>&2
    echo "Make sure you're using official Debian or Ubuntu AMIs, or the Linode-provided" 1>&2
    echo "distribution images." 1>&2
    exit 3
  fi
fi

# If our modprobe command caused the device-mapper module to be loaded, then we need to add a line
# to /etc/modules so the module will be loaded on boot.
if [[ $dm_report =~ 'insmod' ]]; then
  echo 'dm_mod' >> /etc/modules
fi

# If we're here, then your kernel can support TrueCrypt. Yay!
echo 'Congratulations, your kernel has the necessary TrueCrypt prerequisites!'
