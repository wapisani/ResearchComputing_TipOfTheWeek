#! /bin/bash
#
# BASH script to count the number of occurances of each word in a specified 
# file and print the results.
# 
# If option -h is specified with any other option, -h takes precedence over 
# all other options.
#
# Usage: 
# word_count -h
# word_count.sh -F FILENAME
#
# For testing purposes, one may download a book in plain text format from 
# Project Gutenberg website using the command:
#
#   wget http://www.gutenberg.org/files/44362/44362-0.txt


# Function to display error message (help text)
show_help() {
  echo
  echo "  Usage: `basename $0` -h"
  echo "         `basename $0` -F FILENAME"
  echo
  echo "    e.g. `basename $0`"
  echo "         `basename $0` -F 44362-0.txt"
  echo
  exit
}

# -F must have a parameter value
# -h doesn't need a parameter value
while getopts :F:h option
do
  case "$option" in
     
    # -h
    h)
      show_help
      ;;

    # -F
    F)
      # If -F is specified with no value, display help
      if [ -n $OPTARG ]
      then
        FILENAME="$OPTARG"
      else
        show_help
      fi
      ;;

    # If nothing is specified, display help
    *)
      show_help
      ;;

  esac
done

# Validate FILENAME
# Check if FILENAME variable is empty
if [ -z $FILENAME ]
then
  show_help
fi

# Check if the file exists
if [ ! -e "$FILENAME" ]
then
  echo
  echo "  $FILENAME does not exit."
  echo "  Exiting."
  echo
  exit
fi

# Check if file has non-zero size
FILESIZE=$(du $FILENAME | awk '{ print $1 }');
if [ "$FILESIZE" -eq 0 ]
then
  echo
  echo "  $FILENAME exists but is empty."
  echo "  Exiting."
  echo
  exit
fi

# Check if the file has any useful information in spite of
# non-zero size
NON_BLANK_LINES=`sed '/^$/d' $FILENAME | wc -l`
if [ "$NON_BLANK_LINES" -eq 0 ]
then
  echo
  echo "  $FILENAME exists and is not empty but "
  echo "  has no useful information."
  echo "  Exiting."
  echo
  exit
fi

# Count the words and print to the screen
echo
echo "  --------------------------------------"
echo "    #####  Word                  Count"
echo "  --------------------------------------"

# egrep with the given options retains only words, numbers
# and words with numbers
egrep -o "\b[[:alnum:]]+\b" $FILENAME | \
  sort                                | \
  uniq -c                             | \
  sort -n                             | \
  awk '{ printf("    %5d  %-20s   %4d\n", NR, $2, $1); }'

echo "  --------------------------------------"
echo
