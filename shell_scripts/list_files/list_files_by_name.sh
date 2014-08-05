#! /bin/bash
#
# BASH script to list all files in a given directory that have PART_OF_THE_NAME
# as part of their name.
# 
# If option -h is specified with any other option, -h takes precedence over 
# all other options.
#
# Usage: 
# list_file_by_name.sh -h
# list_file_by_name.sh [-l LOCATION] -f PART_OF_THE_NAME


# Function to display error message (help text)
show_help() {
  echo
  echo "  Usage: `basename $0` -h"
  echo "         `basename $0` [-l LOCATION] [-f PART_OF_THE_NAME]"
  echo
  echo "    e.g. `basename $0`"
  echo "         `basename $0` -f txt"
  echo "         `basename $0` -l /research/john"
  echo "         `basename $0` -l /research/john -f txt"
  echo
  exit
}

# -l and -f must have parameter values
# -h doesn't need a parameter value
while getopts :l:f:h option
do
  case "$option" in
     
    # -h
    h)
      show_help
      ;;

    # -l
    l)
      # If -l is specified with no value, display help
      if [ -n $OPTARG ]
      then
        LOCATION="$OPTARG"
      else
        show_help
      fi
      ;;

    # -f
    f)
      # If -f is specified with no value, display help
      if [ -n $OPTARG ]
      then
        NAME="$OPTARG"
      else
        show_help
      fi
      ;;
  esac
done

# If NAME is empty, then assume any file type
if [ -z $NAME ]
then
  NAME="*"
fi

# If LOCATION is empty, then assume present working directory
if [ -z $LOCATION ]
then
  LOCATION=`pwd`
fi

# List all files that that match the criteria
echo
echo "  Location           : $LOCATION"
echo "  File name contains : $NAME"
echo
find $LOCATION -iname "*$NAME*" | sort
echo
