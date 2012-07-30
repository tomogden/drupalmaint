#!/bin/bash
# Shell script by Tom Ogden
# CREATED: 2009-10-22

# This script is meant to iterate through the vhosts directory 
# and compare its modules with the master.  

# set the system path for the multi-site sites directory
SITESROOT=/var/www/vhosts
toG=/var/www/vhosts/theogdengroup.net/subdomains/master/httpdocs/sites/all/modules

# LOOP THROUGH MASTER MODULES
for module

# LOOP THROUGH SITES
cd $toG
count=0
for modl in $(ls |egrep -v "") 
do
    if [ -e $modl/$modl.info ] ; then 
	cd $modl
	toGmod[$count]=$modl
	ver=grep "version"
	toGver[$count]=$ver
	cd ..
        count++
    fi
done

# LOOP THROUGH MASTER MODULES
cd $SITESROOT # work in the right dir
#echo "Running SYNC for $SITESROOT sites."
for site in $(ls |egrep -v "chroot|default")
do
    INDIR=false
    if [ -e /var/www/vhosts/$site/httpdocs/cron.php ] ; then 
	cd /var/www/vhosts/$site/httpdocs/  
	INDIR=true
    else 
      if [ -e /var/www/vhosts/$site/httpdocs/drupal/cron.php ] ; then 
        cd /var/www/vhosts/$site/httpdocs/drupal/
	INDIR=true
      fi 
    fi 
    if [ $INDIR ] ; then
	
    fi
done 
