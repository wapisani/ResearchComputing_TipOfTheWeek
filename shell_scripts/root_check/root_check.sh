#! /bin/bash
#
# BASH script to check if the currently logged in user is root. 
# Applications include scripts that need to be run only as root.
#
# Usage: 
# root_check.sh


# Check if the currently logged in user is root using the value of
# UID variable. If not, print an error message (help text) and exit
if [ $UID != 0 ]
then
  echo
  echo "  Not logged in as root! Exiting."
  echo
  exit
fi
