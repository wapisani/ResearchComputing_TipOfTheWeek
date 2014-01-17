#! /bin/bash
#
# BASH script to list all network interfaces and the
# associated IP address.
# 
# Usage: 
# list_ip_address.sh


# Necessary variables
EXPECTED_ARGUMENTS=0

# Check if there is any argument supplied at the command line. 
# If yes, print an error message (help text) and exit.
if [ $# -ne $EXPECTED_ARGUMENTS ]
then
  echo
  echo "  Usage: `basename $0`"
  echo
  exit
fi

# List all network interfaces
#   'netstat -i' provides the list
#   Delete the first two lines using 'sed'
#   Extract the first column using 'awk'
NETWORK_INTERFACES=`netstat -i   | \
                      sed '1,2d' | \
                      awk -F ' ' '{ print $1 }'`

# Formatted output
i=1
echo
echo "  ----------------------------------------"
echo "    ##  Interface  IP Address and Subnet "
echo "  ----------------------------------------"

# IP address associated with each network interface
for x in $NETWORK_INTERFACES
do
  # 'ip' lists all information associated with a
  # given network interface
  #   Retain only the line that has "inet " using 'grep'
  #   Extract the secont column using 'awk'
  IP_ADDRESS_SUBNET=`ip addr show $x | \
                       grep "inet "  | \
                       awk -F ' ' '{ print $2 }'`

  # Print the information
  printf "    %02d  %-9s  %s\n" "$i" "$x" "$IP_ADDRESS_SUBNET"

  # Increment the index 'i'
  i=`expr $i + 1`
done

# Formatted output
echo "  ----------------------------------------"
echo
