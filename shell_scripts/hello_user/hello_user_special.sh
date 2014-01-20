#! /bin/bash
#
# BASH script to print "Hello, USERNAME!" to the screen, along with the 
# hostname and current date/time iff a username is supplied at the command 
# line.
# 
# Usage:
# hello_user_special.sh USERNAME


# Necessary variables
EXPECTED_ARGUMENTS=1

# Check if the username is supplied at the command line. If not, print an 
# error message (help text) and exit
if [ $# -ne $EXPECTED_ARGUMENTS ]
then
  echo
  echo "  Usage: `basename $0` USERNAME"
  echo "   e.g.: `basename $0` john"
  echo
  exit
fi

# Variables
USERNAME="$1"

# Print to the terminal
echo
echo "  Hello, $USERNAME!"
echo "  Hostname  : `hostname`"
echo "  Date/Time : `date -R`"
echo
