#! /bin/bash
#
# BASH script to add a series of given numbers and print the 
# sum to the screen. Works for integers and non-integers alike. 
# 'getopts' does not support "long option" format 
# (i.e., --help, --begin, --step, --end, etc.).
# 
# If option -h is specified with any other option, -h takes 
# precedence over all other options.
#
# Usage: 
# sum_numbers_getopts.sh -h
# sum_numbers_getopts.sh -B BEGIN [-S STEP] -E END


# Function to display error message (help text)
show_help() {
  echo
  echo "  Usage: `basename $0` -h"
  echo "         `basename $0` -B BEGIN [-S STEP] -E END"
  echo
  echo "    e.g. `basename $0` -B 1 -S 2 -E 100"
  echo "         `basename $0` -B 1 -E 100"
  echo
  exit
}


# The 'getopts' command is built into the BASH shell. It looks
# a lot like 'getopt', but 'getopts' command works on the 
# existing shell parameter variables sequentially. It processes 
# the parameters it detects in the command line one at a time 
# each time it’s called. When it runs out of parameters, it 
# exits with an exit status greater than zero. This makes it 
# suitable for using in loops to parse all of the parameters 
# on the command line. The syntax of the 'getopts' command is:
#
#   getopts optstring variable
#
# One should list valid option letters in the 'optstring', 
# along with a colon if the option letter requires a parameter 
# value. To suppress error messages, one should start the 
# 'optstring' with a colon. The 'getopts' command places the 
# current parameter in the variable defined in the command 
# line ('option' in this case).
#
# The OPTARG environment variable contains the value to be 
# used if an option requires a parameter value. The OPTIND 
# environment variable contains the value of the current 
# location within the parameter list where 'getopts' left 
# off. This allows one to continue processing other command 
# line parameters after finishing the options.

# -B, -S and -E must have parameter values
# -h doesn't need a parameter value
while getopts :B:E:S:h option
do
  case "$option" in
     
    # -h
    h)
      show_help
      ;;

    # -B
    B)
      # If -B is specified with no value, display help
      if [ -n $OPTARG ]
      then
        BEGIN="$OPTARG"
      else
        show_help
      fi
      ;;

    # -S
    S)
      # If -S is specified with no value, display help
      if [ -n $OPTARG ]
      then
        STEP="$OPTARG"
      else
        show_help
      fi
      ;;

    # -E
    E)
      # If -E is specified with no value, display help
      if [ -n $OPTARG ]
      then
        END="$OPTARG"
      else
        show_help
      fi
      ;;

    # If nothing is specified, display help
    *)
      show_help
      ;;

  esac
done

# Check to make sure that BEGIN, STEP and END have 
# appropriate values
if [ -z $BEGIN ] || [ -z $END ]
then
  show_help
fi

# If STEP is empty, then assume steps of 1
if [ -z $STEP ]
then
  STEP="1"
fi

# Generate the sequence of numbers using 'seq'
#   Calcuate and print the sum using 'awk'
SUM=`seq $BEGIN $STEP $END | \
       awk '{ sum += $1 } END { print sum }'`

# Print to screen
echo
echo "  Begin (-B) : $BEGIN"
echo "  Step  (-S) : $STEP"
echo "  End   (-E) : $END"
echo "  Sum        : $SUM"
echo
