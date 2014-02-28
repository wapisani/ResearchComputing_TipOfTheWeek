#! /bin/bash
#
# BASH script to run LaTeX+BibTeX and convert the DVI to PDF.
# It also removes unncessary files.
#
# Usage:
# lbtex.sh LATEX_FILENAME


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
export EXTENSION=`echo "$FILENAME" | awk -F '.' '{ print $NF }'`

# Check if file has .tex extension. If not, print an error message (help text) 
# and exit
if [ "$EXTENSION" != "tex" ]
then
  echo
  echo "  $FILENAME does not have .tex extension."
  echo "  Exiting."
  echo
  exit
fi

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
NON_BLANK_LINES=`sed '/^ *%/d;s/%.*//' $FILENAME | sed '/^$/d' | wc -l`
if [ "$NON_BLANK_LINES" -eq 0 ]
then
  echo
  echo "  $FILENAME exists and is not empty but has no useful information."
  echo "  Exiting."
  echo
  exit
fi

# Run LaTeX twice, BibTeX twice, LaTeX twice and convert DVI to PDF
echo
echo "  Running LaTeX on $FILENAME and convert to PDF"
latex  $FILENAME &> /dev/null
latex  $FILENAME &> /dev/null
bibtex $BASENAME &> /dev/null
bibtex $BASENAME &> /dev/null
latex  $FILENAME &> /dev/null
latex  $FILENAME &> /dev/null
dvipdf $BASENAME.dvi $BASENAME.pdf

# Delete unnecessary files
echo "  ... Done ... Now deleting unnecessary files"
rm -f $BASENAME.aux $BASENAME.out $BASENAME.toc 
rm -f $BASENAME.lof $BASENAME.lot $BASENAME.log 
rm -f $BASENAME.blg $BASENAME.lot $BASENAME.bbl 
echo "  ... Done"
echo
