#! /bin/bash
#
# BASH script to run LaTeX and convert the DVI to PDF.
# It also removes unncessary files.
#
# Usage:
# ltex.sh LATEX_FILENAME


# Necessary variables
EXPECTED_ARGS=1

# Check if a LaTeX file is supplied at the command line. If not, print 
# an error message (help text) and exit
if [ $# -ne $EXPECTED_ARGS ]
then
  echo
  echo "  Usage: `basename $0` LATEX_FILENAME"
  echo "   e.g.: `basename $0` sample.tex"
  echo
  exit
fi

# Save the filename and extract the basename (i.e., without .tex)
export FILENAME="$1"
export BASENAME=`echo "$FILENAME"  | awk -F '.' '{ print $1 }'`

# Run LaTeX twice and convert DVI to PDF.
# If need be, convert DVI to PS and then PS to PDF
echo
echo "  Running LaTeX on $FILENAME and converting to PDF"
latex  $FILENAME &> /dev/null
latex  $FILENAME &> /dev/null
dvipdf $BASENAME.dvi $BASENAME.pdf

# Delete unnecessary files
echo "  ... Done ... Now deleting unnecessary files"
rm -f $BASENAME.aux $BASENAME.out $BASENAME.toc 
rm -f $BASENAME.lof $BASENAME.lot $BASENAME.log 
echo "  ... Done"
echo
