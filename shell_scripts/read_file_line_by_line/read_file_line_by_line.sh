#! /bin/bash
#
# BASH script to read a given file, one line at a time, and parse the line
# to accomplish a desired task.
#
# This particular script assumes that any line that is empty or any line that
# begins with # is less useful, and as such ignores them. The file used to
# demonstrate the script has four fields -- student name and her/his score in
# three assignments -- separated by |. The desired task is to display the 
# student name, individual assignment score as well as the cumulative score,
# average score, and an associated letter grade.
#
# Usage:
# read_file_line_by_line.sh FILENAME


# Necessary variables
EXPECTED_ARGUMENTS=1

# Check if a file is supplied at the command line. If not, print an error 
# message (help text) and exit
if [ $# -ne $EXPECTED_ARGUMENTS ]
then
  echo
  echo "  Usage: `basename $0` FILENAME"
  echo "   e.g.: `basename $0` students.txt"
  echo
  exit
fi

# Function to convert score into letter grade
score2grade() {

  # Input
  local original_score=${1}

  # Sanitized score (strip off all non-numeric characters)
  sanitized_score=`echo "$original_score" | sed 's/[^0-9\.]//g'`

  # Assign a letter grade to sanitized score
  case $sanitized_score in
    100.00)
      echo "A"
    ;;
    9[0-9].[0-9][0-9])
      echo "A"
    ;;
    8[0-9].[0-9][0-9])
      echo "B"
    ;;
    7[0-9].[0-9][0-9])
      echo "C"
    ;;
    6[0-9].[0-9][0-9])
      echo "D"
    ;;
    [1-5][0-9].[0-9][0-9])
      echo "F"
    ;;
    [0-9].[0-9][0-9])
      echo "F"
    ;;
  esac
}

# Save the filename
FILENAME="$1"

# Check if file exists. If not, print an error message (help text) and exit
if [ ! -e "$FILENAME" ]
then
  echo
  echo "  $FILENAME does not exist."
  echo "  Exiting."
  echo
  exit
fi

# Check if file has zero size. If yes, print an error message (help text)
# and exit
FILE_SIZE=$(du $FILENAME | awk '{print $1}')
if [ "$FILE_SIZE" -eq 0 ]
then
  echo
  echo "  $FILENAME exists but is empty."
  echo "  Exiting."
  echo
  exit
fi

# Check if file has non-zero size but has any useful information. If not, 
# print an error message (help text) and exit
NON_BLANK_LINES=`sed '/^ *#/d;s/#.*//' $FILENAME | sed '/^$/d' | wc -l`
if [ "$NON_BLANK_LINES" -eq 0 ]
then
  echo
  echo "  $FILENAME exists and is not empty but has no useful information."
  echo "  Exiting."
  echo
  exit
fi

# Create a temporary sanitized file
SANITIZED_FILENAME="${FILENAME}_$$"
sed '/^ *#/d;s/#.*//' $FILENAME | sed  '/^$/d' > $SANITIZED_FILENAME

# Formatted output
i=0
echo
echo "  --------------------------------------------------------------"
printf "  %-2s  %-20s  %3s  %3s  %3s  %-5s  %-7s  %-5s\n" "##" "Student" "#1" "#2" "#3" "Total" "Average" "Grade"
echo "  --------------------------------------------------------------"

# Read through the sanitized file one line at a time
exec<$SANITIZED_FILENAME
while read student_info
do
  # Increment the index 'i'
  i=`expr $i + 1`

  STUDENT_NAME=`echo $student_info | awk -F '|' '{ print $1 }' | sed 's/^[ \t]*//;s/[ \t]*$//'`
  ASSIGNMENT_1=`echo $student_info | awk -F '|' '{ print $2 }' | sed 's/^[ \t]*//;s/[ \t]*$//'`
  ASSIGNMENT_2=`echo $student_info | awk -F '|' '{ print $3 }' | sed 's/^[ \t]*//;s/[ \t]*$//'`
  ASSIGNMENT_3=`echo $student_info | awk -F '|' '{ print $4 }' | sed 's/^[ \t]*//;s/[ \t]*$//'`
  TOTAL_SCORE=`echo "$ASSIGNMENT_1 + $ASSIGNMENT_2 + $ASSIGNMENT_3" | bc`
  AVERAGE_SCORE=`echo "scale=2; $TOTAL_SCORE/3" | bc`
  LETTER_GRADE=`score2grade $AVERAGE_SCORE`
  printf "  %2d  %-20s  %3d  %3d  %3d  %5d  %7s  %5s\n" "$i" "$STUDENT_NAME" "$ASSIGNMENT_1" "$ASSIGNMENT_2" "$ASSIGNMENT_3" "$TOTAL_SCORE" "$AVERAGE_SCORE" "$LETTER_GRADE"
done

# Formatted output
echo "  --------------------------------------------------------------"
echo

# Delete the temporary sanitized file
rm -f $SANITIZED_FILENAME
