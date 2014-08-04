#! /bin/bash
#
# BASH script to convert seconds into human readable format.
#
# Usage:
# seconds2hrf.sh SECONDS


# Necessary variables
EXPECTED_ARGS=1
 
# Check if number of seconds is supplied at the command line. If not, 
# print an error message (help text) and exit
if [ $# -ne $EXPECTED_ARGS ]
then
  echo
  echo "  Usage: `basename $0` SECONDS"
  echo "   e.g.: `basename $0` 1234"
  echo
  exit
fi

# Save the number of seconds
SECONDS="$1"

# Convert seconds to days, hours, minutes and seconds
DD=`echo "$SECONDS/86400" | bc`
HH=`echo "$SECONDS%86400/3600" | bc`
MM=`echo "$SECONDS%3600/60" | bc`
SS=`echo "$SECONDS%60" | bc`

# Print the result to the screen
printf "%d:%02d:%02d:%02d\n" $DD $HH $MM $SS
