#! /bin/bash
#
# BASH script to check if a file has non-zero size.
# Applications include checking if a file has non-zero size, along with
# existence check (check_file_existence.sh), before proceeding ahead with
# parsing/processing it.
#
# Usage:
# check_file_size.sh FILENAME


# Necessary variables
EXPECTED_ARGS=1

# Check if a filename is supplied at the command line. If not, print 
# an error message (help text) and exit
if [ $# -ne $EXPECTED_ARGS ]
then
  echo
  echo "  Usage: `basename $0` LATEX_FILENAME"
  echo "   e.g.: `basename $0` sample.tex"
  echo
  exit
fi

# Save the filename
export FILENAME="$1"

# Check if the file has zero size. If yes, print an error message (help text)
# and exit
FILE_SIZE=$(du $FILENAME | awk '{print $1}')
if [ "$FILE_SIZE" -eq 0 ]
then
  echo
  echo "  $FILENAME exists but is empty."
  echo "  Exiting."
  echo
  exit
fi
