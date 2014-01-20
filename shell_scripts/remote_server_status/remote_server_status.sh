#! /bin/bash
#
# BASH script to ping a given remote server identified by an IP address]. 
# Applications include using this as a preliminary test of 'remote server 
# being alive' before attempting to transfer files (e.g., data backup via 
# cron jobs, etc.). 
#
# Potential enhancements include validating the IP address.
# 
# Usage: 
# remote_server_status.sh IP_ADDRESS


# Necessary variables
EXPECTED_ARGUMENTS=1

# Check if an IP address is supplied at the command line. If not, print an 
# error message (help text) and exit
if [ $# -ne $EXPECTED_ARGUMENTS ]
then
  echo
  echo "  Usage: `basename $0`"
  echo "   e.g.: `basename $0` IP_ADDRESS"
  echo
  exit
fi

# Variables
SERVER="$1"
PING_COUNT=2

# Ping the remote server N times quietly
#   Select the line that contains "packet loss"
PING_REQUESTS=`ping -c $PING_COUNT -q $SERVER | \
                 grep "packet loss"`

# Count the number of pings (KNOCK_KNOCK), number of responses (WHO_IS_THERE) 
# and create a state for the network and/or the remote server
SENT=`echo $PING_REQUESTS | \
        awk -F ' ' '{ print $1 }'`
RECD=`echo $PING_REQUESTS | \
        awk -F ' ' '{ print $4 }'`

if [ $RECD -eq $SENT ]
then
  STATUS="Excellent"
else
  # 75% packets received
  if [ $RECD -le `echo "$SENT * (3/4)" | bc` ]
  then
    STATUS="Average"
  fi

  # 50% packets received
  if [ $RECD -le `echo "$SENT * (2/4)" | bc` ]
  then
    STATUS="Poor"
  fi

  # 25% packets received
  if [ $RECD -le `echo "$SENT * (1/4)" | bc` ]
  then
    STATUS="Very poor"
  fi

  # 0 packets received
  if [ $RECD -eq 0 ]
  then
    STATUS="Down"
  fi
fi

# Print the information
echo
echo "  -----------------------------------------------"
echo "                     -- Ping --  Server/Network"
echo "    Remote server    Sent  Recd      status"
echo "  -----------------------------------------------"
printf "    %-15s  %02d    %02d    %s\n" "$SERVER" "$SENT" "$RECD" "$STATUS"
echo "  -----------------------------------------------"
echo
