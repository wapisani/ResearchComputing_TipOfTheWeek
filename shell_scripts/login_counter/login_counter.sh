#! /bin/bash
#
# BASH script to count and display usernames in descending 
# order of the number of successful login attempts.
#
# Usage:
# login_counter.sh


# Necessary variables
EXPECTED_ARGUMENTS=0

# Check if there is any argument supplied at the command line. 
# If yes, print an error message (help text) and exit.
if [ $# -ne $EXPECTED_ARGUMENTS ]
then
  echo
  echo "  Usage: `basename $0`"
  echo
  exit
fi

# Date/Time when the record keeping began
#  System's own record of login attempts using 'last'
#  Ignore everything but the very last line using 'tail'
#  Select the last field (date and time) using 'awk' with 
#    "wtmp begins " as the field separator
RECORD_START_DATE=`last      | \
                     tail -1 | \
                     awk -F 'wtmp begins ' '{ print $NF }'`

# Print to the screen
echo
echo "  Hostname   : `hostname`"
echo "  Start date : $RECORD_START_DATE"
echo 
#   System's own record of login attempts using 'last'
#   Delete all blank lines using 'sed'
#   Ignore all lines that contain 'wtmp'
#   Select the first field (username) using 'awk' using 
#     space as the field separator
#   Sort the first column using 'sort'
#   Count the number of duplicate lines using 'uniq'
#   Reverse sort the list using 'sort' to get the 
#     descending order
last                        | \
  sed '/^$/d'               | \
  grep -v "wtmp"            | \
  awk -F ' ' '{ print $1 }' | \
  sort                      | \
  uniq -c                   | \
  sort -nr
echo
