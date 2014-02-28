#! /bin/bash
#
# BASH script to check the spelling of a given (set of) word(s).
#
# Usage: 
# spell_check.sh WORD1 [WORD2] ... [WORDn]


# Necessary variables
MINIMUM_ARGUMENTS=1

# Check if a word (or more) is supplied at the command line. If not, print
# an error message (help text) and exit
if [ $# -lt $MINIMUM_ARGUMENTS ]
then
  echo
  echo "  Usage: `basename $0` WORD1 [WORD2] ... [WORDn]"
  echo "   e.g.: `basename $0` spelling"
  echo "         `basename $0` spelling spleling wonder"
  echo
  exit
fi

# Variables
SPELL="ispell -l"

# Formatted output
i=1
echo
echo "  ---------------------------------"
echo "    ##  Word            Spelling"
echo "  ---------------------------------"

# Check the spelling of each supplied word
for word
do
  if [ -z $(echo $word | $SPELL) ]
  then
    printf "    %02d  %-14s  %s\n"  "$i" "$word" "Correct"
  else
    printf "    %02d  %-14s  %s\n"  "$i" "$word" "Incorrect"
  fi

  # Increment the index 'i'
  i=`expr $i + 1`
done

# Formatted output
echo "  ---------------------------------"
echo
