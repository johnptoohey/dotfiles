#!/bin/bash

new_label=$1
if [ -z "$new_label" ]; then
  echo "usage: set-osx-label-and-permissions.sh label [old-label]" 1>&2
  exit 1
fi

new_label=`echo "$new_label" | tr '[a-z]' '[A-Z]' | sed -e 's/ //g'`
uid=`id -u`

old_label=$2
if [ -z "$old_label" ]; then
  old_label="NO NAME"
fi

disk_search=`/usr/sbin/diskutil list | grep "$old_label"`
if [ -z "$disk_search" ]; then
  echo "Could not find any volumes with the label \"$old_label\" to rename!" 1>&2
  exit 2
fi

sudo /usr/sbin/diskutil rename "$old_label" $new_label

if [ -e /etc/fstab ]; then
  echo "LABEL=$new_label none msdos -u=$uid,-m=700" | cat /etc/fstab - | sudo tee /etc/fstab >/dev/null
else
  echo "LABEL=$new_label none msdos -u=$uid,-m=700" | sudo tee /etc/fstab >/dev/null
fi

echo "Permissions configured! Please unmount and then re-mount the volume."
