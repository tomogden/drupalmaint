#!/bin/bash
# Shell script by Tom Ogden
# CREATED: 2009-10-22
# Copy the module named from the base Drupal site to the current directory.  
# SYNTAX: cpmod mymodule

TOG=/var/www/vhosts/theogdengroup.net/subdomains/master/httpdocs
TOGMODS=$TOG/sites/all/modules
TOGMODDIR="$TOGMODS/$1"

if [[ -e $TOGMODDIR && $1 != "" ]] ; then
  if [ -e "$1" ] ; then
    rm -rf "$1"
  fi
  cp -r $TOGMODDIR .
else
  echo "Module '$1' doesn't exist at the base installation."
fi

