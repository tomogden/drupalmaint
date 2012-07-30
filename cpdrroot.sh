#!/bin/bash
# Shell script by Tom Ogden
# CREATED: 2009-10-22
# Copy the file or directory from the root of the base Drupal site to the current directory.  
# SYNTAX: cpdrroot myitem

TOG=/var/www/vhosts/theogdengroup.net/subdomains/master/httpdocs
TOGDIR="$TOG/$1"

if [[ -e $TOGDIR && $1 != "" ]] ; then
  if [ -e "$1" ] ; then
    rm -rf "$1"
  fi
  cp -r $TOGDIR .
else
  echo "Item '$1' doesn't exist at the base installation."
fi

