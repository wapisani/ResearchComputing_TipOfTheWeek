#! /bin/bash
#
# BASH script to print "Hello, USERNAME!" to the screen, along
# the hostname, current date/time and current working directory.
# USERNAME is the username of currently logged in user.
# 
# Usage:
# ./hello_user_regular.sh


# Print to the screen
echo
echo "  Hello, $USER!"
echo "  Hostname  : `hostname`"
echo "  Date/Time : `date -R`"
echo "  Location  : `pwd -P`"
echo
