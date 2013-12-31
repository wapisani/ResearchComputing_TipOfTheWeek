#! /bin/bash
#
# BASH script to print "Hello, USERNAME!" to the screen, 
# along with the hostname and current date/time. USERNAME
# is the username supplied at the command line; if not 
# supplied, use the currently logged in user's username.
# 
# Usage:
# hello_user_premium.sh [USERNAME]


# Necessary variables
MAXIMUM_ARGUMENTS=1

# Check if more than the maximum number of arguments have 
# been supplied at the command line. If yes, print an 
# error message (help text) and exit.
if [ $# -gt $MAXIMUM_ARGUMENTS ]
then
  echo
  echo "  Usage: `basename $0` [USERNAME]"
  echo "   e.g.: `basename $0` john"
  echo "         `basename $0`"
  echo
  exit
fi

# Check if the username is supplied at the command line.
# If yes, set USERNAME to supplied value; if not, set it
# to username of currently logged in user.
if [ $# -eq $MAXIMUM_ARGUMENTS ]
then
  USERNAME="$1"
else
  USERNAME="$USER"
fi

# Print to the screen
echo
echo "  Hello, $USERNAME!"
echo "  Hostname  : `hostname`"
echo "  Date/Time : `date -R`"
echo
