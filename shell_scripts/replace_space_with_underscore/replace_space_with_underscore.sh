#! /bin/bash
#
# BASH script to replace one or more spaces in file names with an underscore. 
# One may create, for testing purposes, files with space in their name as
#
#   touch "file name 1.txt"
#   touch "file name 2.txt"
#   touch "file name 3.txt"
# 
# and so on.
#
# Usage:
# replace_space_with_underscore.sh


# Necessary variables
EXPECTED_ARGUMENTS=0

# Check if there is any argument supplied at the command line. If yes, print 
# an error message (help text) and exit
if [ $# -ne $EXPECTED_ARGUMENTS ]
then
  echo
  echo "  Usage: `basename $0`"
  echo
  exit
fi

# Loop through the list of files (use *.txt or *.dat, etc. to limit the 
# selection to specific file types) and replace space with an underscore - if 
# and only if the new file name (with underscores) does not already exist
echo
for x in *
do
  y=$(echo "$x" | tr ' ' '_')

  if [ -e $y ]
  then
    printf "  %25s --x--> %-25s (already exists)\n" "$x" "$y"
  else
    printf "  %25s -----> %-25s\n" "$x" "$y"
    mv "$x" "$y"
  fi
done
echo
