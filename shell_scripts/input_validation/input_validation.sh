#! /bin/bash
#
# BASH script to validate user input. Each function makes
# sure a user's input is alphabetical, numeric or alphanumeric. 
#
# Technique is to strip off all non-desired characters from
# the string (user input) using 'sed' ('tr' and 'awk' may also 
# be used to accomplish this task). If the stripped version is 
# identical to the original string, then the user input is
# valid (exit value: 0); invalid otherwise (exit value: 1).
#
# A recommended way is to store these functions in a separate 
# file (say, functions.sh) and source them for general use by 
# more than one shell script.
# 
# Usage:
# input_validation.sh


# Necessary variables
EXPECTED_ARGUMENTS=0

# Check if more than the expected number of arguments have  
# been supplied at the command line. If yes, print an error
# message (help text) and exit.
if [ $# -ne $EXPECTED_ARGUMENTS ]
then
  echo
  echo "  Usage: `basename $0`"
  echo
  exit
fi

# Function #1: alphabetic input
validate_alphabetic() {

  # User input
  local string=${1}

  # Strip off all non-alphabetic characters from string
  sanitized_string=`echo "$string" | sed 's/[^a-zA-Z]//g'`

  # Compare string and sanitized_string, and return a value
  if [ "$string" != "$sanitized_string" ]
  then
    # Invalid user input
    return 1
  else
    # Valid user input
    return 0
  fi
}
# Function #1: alphabetic input

# Function #2: numeric input
validate_numeric() {

  # User input
  local string=${1}

  # Strip off all non-alphabetic characters from string
  sanitized_string=`echo "$string" | sed 's/[^0-9]//g'`

  # Compare string and sanitized_string, and return a value
  if [ "$string" != "$sanitized_string" ]
  then
    # Invalid user input
    return 1
  else
    # Valid user input
    return 0
  fi
}
# Function #2: numeric input

# Function #3: alphanumeric input
validate_alphanumeric() {

  # User input
  local string=${1}

  # Strip off all non-alphanumeric characters from string
  sanitized_string=`echo "$string" | sed 's/[^a-zA-Z0-9]//g'`

  # Compare string and sanitized_string, and return a value
  if [ "$string" != "$sanitized_string" ]
  then
    # Invalid user input
    return 1
  else
    # Valid user input
    return 0
  fi
}
# Function #3: alphanumeric input


# Accept user input
echo
echo -n "  User input: "
read USER_INPUT
echo

# Uncomment only one of the three validations below:
# Alphabetic validation
# Note: '[ ... ]' is not a part of 'if' syntax by default;
# Using 'if [ ! validate_alphabetic "$USER_INPUT" ]' will
# result in errors.
if ! validate_alphabetic "$USER_INPUT"
then
  echo "  Invalid (contains non-alphabetic charcaters)"
  echo
  exit
else
  echo "  Valid"
  echo
fi

# Numeric validation
# Note: '[ ... ]' is not a part of 'if' syntax by default;
# Using 'if [ ! validate_numeric "$USER_INPUT" ]' will
# result in errors.
if ! validate_numeric "$USER_INPUT"
then
  echo "  Invalid (contains non-numeric charcaters)"
  echo
  exit
else
  echo "  Valid"
  echo
fi

# Alphanumeric validation
# Note: '[ ... ]' is not a part of 'if' syntax by default;
# Using 'if [ ! validate_alphanumeric "$USER_INPUT" ]' will
# result in errors.
if ! validate_alphanumeric "$USER_INPUT"
then
  echo "  Invalid (contains non-alphanumeric charcaters)"
  echo
  exit
else
  echo "  Valid"
  echo
fi
