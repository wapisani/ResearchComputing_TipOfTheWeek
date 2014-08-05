#! /bin/bash
#
# BASH script to list all files in a given directory that are equal to or 
# larger than a certain set size (expressed in MB).
# 
# If option -h is specified with any other option, -h takes precedence over 
# all other options.
#
# Usage: 
# list_file_by_size.sh -h
# list_file_by_size.sh [-l LOCATION] [-s SIZE_IN_MB]


# Function to display error message (help text)
show_help() {
  echo
  echo "  Usage: `basename $0` -h"
  echo "         `basename $0` [-l LOCATION] [-s SIZE_IN_MB]"
  echo
  echo "    e.g. `basename $0`"
  echo "         `basename $0` -s 100"
  echo "         `basename $0` -l /research/john"
  echo "         `basename $0` -l /research/john -s 10"
  echo
  exit
}

# -l and -s must have parameter values
# -h doesn't need a parameter value
while getopts :l:s:h option
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

    # -s
    s)
      # If -s is specified with no value, display help
      if [ -n $OPTARG ]
      then
        SIZE="$OPTARG"
      else
        show_help
      fi
      ;;

  esac
done

# If SIZE is empty, then assume 2 MB limit
if [ -z $SIZE ]
then
  SIZE="2"
fi

# Convert size (in MB) to kB
SIZE_IN_KB=`echo "$SIZE * 1024" | bc`

# If LOCATION is empty, then assume present working directory
if [ -z $LOCATION ]
then
  LOCATION=`pwd`
fi

# Necessary variables
KILOBYTE="1024"
MEGABYTE=`echo "$KILOBYTE * 1024" | bc`
GIGABYTE=`echo "$MEGABYTE * 1024" | bc`

# List all files that are at least 2 MB in $LOCATION using 'find', 'awk' and
# 'sed' commands
echo
echo "  Location  : $LOCATION"
echo "  Min. size : $SIZE MB"
echo
find $LOCATION -name '*' -size +${SIZE_IN_KB}k -ls | \
  awk --assign=MB="$MEGABYTE" \
  '{ filesize+=$7; printf(" %5d MB  %s\n", $7/MB, $11); }' | \
  sort -nr
echo
