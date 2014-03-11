#! /bin/bash
#
# BASH script to check if a file has useful information.
# Applications include checking if a file contains non-comment characters
# before proceeding ahead with parsing/processing it.
#
# Usage:
# check_file_usefulness.sh FILENAME


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

# Check if file has non-zero size but has any useful information. If not, 
# print an error message (help text) and exit
# '%' is the comment character in MATLAB and LaTeX. Replace it with the
# appropriate comment character for a different language ('#' for shell
# scripting and PHP, etc.)
NON_BLANK_LINES=`sed '/^ *%/d;s/%.*//' $FILENAME | sed '/^$/d' | wc -l`
if [ "$NON_BLANK_LINES" -eq 0 ]
then
  echo
  echo "  $FILENAME exists and is not empty but has no useful information."
  echo "  Exiting."
  echo
  exit
fi
