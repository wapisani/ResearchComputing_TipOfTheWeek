#! /bin/bash
#
# BASH script to automagically uncompress different kinds of
# compresed files/folders based on the filename extension.
# 
# Usage:
# ./smart_extract.sh COMPRESSED_FILENAME


# Necessary variables
EXPECTED_ARGUMENTS=1

# Check if a compressed filename is supplied at the command 
# line. If not, print an error message (help text) and exit
if [ $# -ne $EXPECTED_ARGUMENTS ]
then
  echo
  echo "  Usage: `basename $0` COMPRESSED_FILENAME"
  echo "   e.g.: `basename $0` file.tar.gz"
  echo "         `basename $0` file.zip"
  echo "         `basename $0` file.bz2"
  echo
  exit
fi

# Variables
COMPRESSED_FILENAME="$1"

# Uncompress the file based on the filename extension
if [ -f $COMPRESSED_FILENAME ]
then
  case $COMPRESSED_FILENAME in
    *.tar)
      tar -xvf  $COMPRESSED_FILENAME
    ;;

    *.tgz)
      tar -xvzf $COMPRESSED_FILENAME
    ;;

    *.tar.gz)
      tar -xvzf $COMPRESSED_FILENAME
    ;;

    *.tbz2)
      tar -xvjf $COMPRESSED_FILENAME
    ;;

    *.tar.bz2)
      tar -xvjf $COMPRESSED_FILENAME
    ;;

    *.gz)
      gunzip    $COMPRESSED_FILENAME
    ;;

    *.bz2) 
      bunzip2   $COMPRESSED_FILENAME
    ;;

    *.zip)
      unzip     $COMPRESSED_FILENAME
    ;;

    *)
      echo "  '$COMPRESSED_FILENAME' file type unknown"
    ;;
  esac
else
  echo
  echo "  '$COMPRESSED_FILENAME' is not a regular file"
  echo
fi
