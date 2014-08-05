#! /bin/bash
#
# BASH script to search through quick notes stored using 'remember_me.sh'.
#
# Usage:
# remind_me.sh SEARCH_STRING


# Necessary variables
MINIMUM_ARGS=1
 
# Check if a string supplied at the command line. If not, 
# print an error message (help text) and exit
if [ $# -lt $MINIMUM_ARGS ]
then
  echo
  echo "  Usage: `basename $0` SEARCH_STRING"
  echo "   e.g.: `basename $0` michigan"
  echo "         `basename $0` michigan tech"
  echo
  exit
fi

# Necessary variables
REMEMBER="$HOME/.remember"
SEARCH_STRING="$@"

# Search through the stored notes (case insensitive search)
grep -B1 -i "$SEARCH_STRING" $REMEMBER
