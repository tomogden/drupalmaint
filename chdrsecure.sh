#!/bin/bash
# Taken from http://drupal.org/node/244924, by Leandro Scott.

if [ -z $1 ]; then
  DRUPAL_USER=$(whoami)
else
  DRUPAL_USER=${1}
fi
if [ -z $2 ]; then
  DRUPAL_PATH="/var/www/html"
else
  DRUPAL_PATH=${2%/}
fi
APACHE_GROUP="apache"
HELP="\nHELP: This script is used to fix permissions of a drupal installation.\nYou need to provide the following arguments:\n\t1) Username of the user that you want to give files/directories ownership\n\t2) Path to your drupal installation\nNote: \"apache\" (apache default) is assumed as the group the server is belonging to, if this is different you need to modify it manually by editing this script\n\nUsage: (sudo) bash ${0##*/} user_name drupal_path\n"

if [ -z "${DRUPAL_PATH}" ] || [ ! -d "${DRUPAL_PATH}/sites" ] || [ ! -f "${DRUPAL_PATH}/modules/system/system.module" ]; then
  echo "Please provide a valid drupal path"
  echo -e $HELP
exit
fi

if [ -z "${DRUPAL_USER}" ] || [ "`id -un ${DRUPAL_USER} 2> /dev/null`" != "${DRUPAL_USER}" ]; then
  echo "Please provide a valid user"
  echo -e $HELP
  exit
fi


cd $DRUPAL_PATH
echo -e "Changing ownership of all contents of \"${DRUPAL_PATH}\" :\n user => \"${DRUPAL_USER}\" \t group => \"${APACHE_GROUP}\"\n"
chown -R $DRUPAL_USER:$APACHE_GROUP .

echo "Changing permissions of all directories inside \"${DRUPAL_PATH}\" to \"rwxr-x---\"..."
find . -type d -exec chmod u=rwx,g=rx,o= '{}' \;

echo -e "Changing permissions of all files inside \"${DRUPAL_PATH}\" to \"rw-r-----\"...\n"
find . -type f -exec chmod u=rw,g=r,o= '{}' \;

echo "Changing permissions of \"files\" directories in \"${DRUPAL_PATH}/sites\" to \"rwxrwx---\"..."
cd $DRUPAL_PATH/sites
find . -type d -name files -exec chmod ug=rwx,o= '{}' \;
echo "Changing permissions of all files inside all \"files\" directories in \"${DRUPAL_PATH}/sites\" to \"rw-rw----\"..."
echo "Changing permissions of all directories inside all \"files\" directories in \"${DRUPAL_PATH}/sites\" to \"rwxrwx---\"..."
for d in ./*/files
do
  find $d -type d -exec chmod ug=rwx,o= '{}' \;
  find $d -type f -exec chmod ug=rw,o= '{}' \;
done

