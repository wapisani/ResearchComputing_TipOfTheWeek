#! /bin/bash
#
# BASH script to store quick (i.e., one line) notes for a later reference.
# Use 'remind_me.sh' to search through the stored quick notes.
#
# Usage:
# remember_me.sh


# Necessary variables
EXPECTED_ARGS=0
 
# Check if the script is called with no options. If not, print an error 
# message (help text) and exit
if [ $# -ne $EXPECTED_ARGS ]
then
  echo
  echo "  Usage: `basename $0`"
  echo
  exit
fi

# Necessary variables
REMEMBER="$HOME/.remember"
DATE_TIME=`date -R`

# Prompt the user for a note to remembered
echo "Enter a quick note to remember [press ENTER key when done]"
read NOTE2REMEMBER
NOTE2REMEMBER_SANITIZED=`echo ${NOTE2REMEMBER} | sed 's/^[ \t]*//;s/[ \t]*$//'`

# Record the note along with the time stamp
echo "# $DATE_TIME"             >> $REMEMBER
echo "$NOTE2REMEMBER_SANITIZED" >> $REMEMBER
echo
