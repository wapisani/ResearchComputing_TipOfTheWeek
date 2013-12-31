#! /bin/bash
#
# BASH script to add a series of given numbers and print 
# the sum to the screen. Works for integers and 
# non-integers alike.
#
# Usage: 
# sum_numbers.sh BEGIN [STEP] END


# Necessary variables
MINIMUM_ARGUMENTS=2
MAXIMUM_ARGUMENTS=3

# Check if the user has supplied less than the minimum OR
# more than the maximum number of arguments at the command 
# line. If yes, print an error message (help text) and exit.
if [ $# -lt $MINIMUM_ARGUMENTS ] || [ $# -gt $MAXIMUM_ARGUMENTS ]
then
  echo
  echo "  Usage: `basename $0` BEGIN [STEP] END"
  echo "   e.g.: `basename $0` 1 1 10"
  echo "         `basename $0` 1 2 10"
  echo "         `basename $0` 1 10"
  echo
  exit
fi

# If the third argument is missing, then assume increments of 1
if [ -z $3 ]
then
  BEGIN="$1"
  STEP="1"
  END="$2"
else
  BEGIN="$1"
  STEP="$2"
  END="$3"
fi

# Generate the sequence of numbers using 'seq'
#   Calcuate and print the sum using 'awk'
SUM=`seq $BEGIN $STEP $END | \
       awk '{ sum += $1 } END { print sum }'`

# Print to screen
echo
echo "  Begin : $BEGIN"
echo "  Step  : $STEP"
echo "  End   : $END"
echo "  Sum   : $SUM"
echo
