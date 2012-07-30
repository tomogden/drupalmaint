#!/bin/bash
# Shell script by Tom Ogden
# CREATED: 2009-10-23
# This script is meant to iterate through the modules directory 
# of a Drupal site and synchronize its modules with the master.  

# set the system path for the multi-site sites directory
TOG=/var/www/vhosts/theogdengroup.net/subdomains/master/httpdocs/sites/all/modules

# LOOP THROUGH LOCAL MODULES

for DRMODULE in $(ls |egrep -v "all|default") 
do
    echo "Checking module '$DRMODULE'."
    if [ -e $DRMODULE/*.info ] ; then # No quotes when using * wildcard.
        INFONAME="$(ls $DRMODULE/*.info)"
        read -r -a INFONAMEARRAY <<< "$INFONAME"
        INFONAME=${INFONAMEARRAY[0]}
	#echo "Filename is '$INFONAME'."
    else
        #echo "Module '$DRMODULE' is missing its .info file."
        #if [ -e $DRMODULE/*/*.info ] ; then # No quotes when using * wildcard.
            INFONAME="$(ls $DRMODULE/*/*.info)"
            read -r -a INFONAMEARRAY <<< "$INFONAME"
            INFONAME=${INFONAMEARRAY[0]}
	    #echo "Filename is '$INFONAME'."
        #fi
    fi

    #if [ $[{#INFONAME} ] ; then 
        VER1=$(grep 'version' "$INFONAME") 
        if [ -e "$TOG/$INFONAME" ] ; then 
            VER0=$(grep 'version' "$TOG/$INFONAME")
            if [ "$VER1" != "$VER0" ] ; then 
                echo "Updating module '$DRMODULE' to '$VER0'."
                sh /root/drupalmaint/cpmod.sh $DRMODULE # Update the given module
            #else 
            #    echo "Module '$DRMODULE' matches '$VER0'."
            fi
        fi
    #fi
done
