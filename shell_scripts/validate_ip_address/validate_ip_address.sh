#! /bin/bash
#
# BASH script to check if a given string is an IP address (IPv4).
# 
# Usage: 
# validate_ip_address.sh IP_ADDRESS


# Necessary variables
EXPECTED_ARGUMENTS=1

# Check if an IP address is supplied at the command line. If not, print an 
# error message (help text) and exit
if [ $# -ne $EXPECTED_ARGUMENTS ]
then
  echo
  echo "  Usage: `basename $0` IP_ADDRESS"
  echo "   e.g.: `basename $0` 123.456.789.012"
  echo
  exit
fi

# Variables
IP_ADDRESS="$1"

# Check if the supplied IP address is in the format ###.####.###.####
# i.e., if IP address is a set of 4 integers separated by '.'
if [[ $IP_ADDRESS =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]
then

  # Save the current/default Internal Field Separator
  OIFS=$IFS

  # Set the default Internal Field Separator to '.'
  IFS='.'

  # Split the string IP_ADDRESS into an array using the new IFS as the
  # field separator
  OCTETS=($IP_ADDRESS)

  # Restore the Internal Field Separator to its default value
  IFS=$OIFS

  # Check if each element of the array is less than 255
  if [[ ${OCTETS[0]} -le 255    && ${OCTETS[1]} -le 255 \
       && ${OCTETS[2]} -le 255 && ${OCTETS[3]} -le 255 ]]
  then
    echo
    echo "    $IP_ADDRESS is valid"
    echo
  else
    echo
    echo "    $IP_ADDRESS is invalid"
    echo
  fi
else
  echo
  echo "    $IP_ADDRESS is invalid"
  echo
fi
