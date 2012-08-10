#!/bin/bash

# 2011-05-03: Run cron using drush.
# 2012-08-10: Only check directories with Drupal's cron.php file.  

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
  if [ -f "$SITESROOT$site/cron.php" ]
  then
    echo ""
    echo "** $site ************************************"
    if [ -e "$SITESROOT$site/cron.php" ] ; then
      cd "$SITESROOT$site"
      /usr/local/bin/drush cron
    fi
  fi
done