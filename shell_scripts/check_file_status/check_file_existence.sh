#! /bin/bash
#
# BASH script to check if a file exists.
# Applications include checking if a file exists before proceeding ahead with
# parsing/processing it.
#
# Usage:
# check_file_existence.sh FILENAME


# Necessary variables
EXPECTED_ARGS=1

# Check if a filename is supplied at the command line. If not, print 
# an error message (help text) and exit
if [ $# -ne $EXPECTED_ARGS ]
then
  echo
  echo "  Usage: `basename $0` FILENAME"
  echo "   e.g.: `basename $0` sample.tex"
  echo "         `basename $0` sample.txt"
  echo
  exit
fi

# Save the filename
export FILENAME="$1"

# Check if the file exists. If not, print an error message (help text) and exit
if [ ! -e "$FILENAME" ]
then
  echo
  echo "  $FILENAME does not exist."
  echo "  Exiting."
  echo
  exit
fi
