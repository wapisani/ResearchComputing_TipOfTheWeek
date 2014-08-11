#! /bin/bash
#
# BASH script to validate user input (numeric)
#
# Technique is to strip off all non-desired characters from the string 
# (user input) using 'sed' ('tr' and 'awk' may also be used to accomplish this 
# task). If the stripped version is identical to the original string, then the 
# user input is valid (exit value: 0); invalid otherwise (exit value: 1).
#
# Use it from another shell script as
# . validate_numeric.sh

validate_numeric() {

  # User input
  local original_string=${1}

  # Strip off all non-numeric characters from original_string
  sanitized_string=`echo "$original_string" | sed 's/[^0-9]//g'`

  # Compare original_string and sanitized_string, and return a value
  if [ "$original_string" != "$sanitized_string" ]
  then
    # Invalid user input
    return 1
  else
    # Valid user input
    return 0
  fi
}
