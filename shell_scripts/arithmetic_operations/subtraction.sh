#! /bin/bash
#
# BASH script to subtract two given numbers.
#
# Usage: 
# subtraction.sh NUMBER1 NUMBER2


# Necessary variables
EXPECTED_ARGS=2

# Check if two numbers are supplied at the command line. If not, print an 
# error message (help text) and exit
if [ $# -ne $EXPECTED_ARGS ]
then
  echo
  echo "  Usage: `basename $0` NUMBER1 NUMBER2"
  echo "   e.g.: `basename $0` 4 2"
  echo "         `basename $0` -4 2.25"
  echo
  exit
fi

# Store the arguments
A=$1
B=$2

# Validate A and B
NUMERIC_INPUT='^-?[0-9]+([.][0-9]+)?$'
if ! [[ $A =~ $NUMERIC_INPUT ]]
then
  echo
  echo "  NUMBER1 is invalid"
  echo
  exit
fi

if ! [[ $B =~ $NUMERIC_INPUT ]]
then
  echo
  echo "  NUMBER2 is invalid"
  echo
  exit
fi

# Arithmetic (subtraction)
C=`echo "$A - $B" | bc -l`

# Print to screen
echo
echo "  NUMBER1 (A) : $A"
echo "  NUMBER2 (B) : $B"
echo "  C = A - B   : $C"
echo
