#!/bin/bash

# 2011-05-03: Run cron using drush. 

# This script will iterate through the www directory of a multiple site install
# and run the cron.php within each site's directory. 
# NOTE: the site defined in 'sites/default' must have its URL set statically here.

# set the domain of the site defined in 'sites/default'
# comment these lines out if you don't need or use them.
# DEFAULTDOMAIN=www.example.com
# wget -O - -q http://$DEFAULTDOMAIN/cron.php

# set the system path for the multi-site sites directory
SITESROOT=/var/www
# set the IP of your server
MYIPRANGE=127.0.0.1

cd $SITESROOT # work in the right dir
for site in $(ls |egrep -v "chroot|default")
do
  #if ping -c 1 $site |grep -q $MYIPRANGE # Don't ping, limits it to main domain only. 
  #then
  echo ""
  echo "** $site ************************************"
  if [ -e /var/www/$site/cron.php ] ; then 
    cd /var/www/$site/  
    /usr/local/bin/drush cron
  fi 
done
