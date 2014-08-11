#! /bin/bash
#
# BASH script to divide two given integers.
#
# Usage: 
# division.sh NUMBER1 NUMBER2


# Necessary variables
EXPECTED_ARGS=2

# Check if two numbers are supplied at the command line. If not, print an 
# error message (help text) and exit
if [ $# -ne $EXPECTED_ARGS ]
then
  echo
  echo "  Usage: `basename $0` NUMBER1 NUMBER2"
  echo "   e.g.: `basename $0` 4 2"
  echo
  exit
fi

# Function to validate user input
. validate_numeric.sh


# Store the arguments
A=$1
B=$2

# Validate A and B
if ! validate_numeric "$A"
then
  echo
  echo "  NUMBER1 is invalid (contains non-numeric charcaters)"
  echo
  exit
fi

if ! validate_numeric "$B"
then
  echo
  echo "  NUMBER2 is invalid (contains non-numeric charcaters)"
  echo
  exit
fi

# Arithmetic (division)
C=$((A / B))

# Print to screen
echo
echo "  NUMBER1 (A) : $A"
echo "  NUMBER2 (B) : $B"
echo "  C = A / B   : $C"
echo
