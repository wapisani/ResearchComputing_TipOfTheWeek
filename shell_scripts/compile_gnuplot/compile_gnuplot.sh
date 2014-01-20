#! /bin/bash
#
# BASH script to download and compile GNUPlot. When completed, it will also 
# create a symbolic link in $HOME/bin/
#
# Usage:
# compile_gnuplot.sh GNUPLOT_VERSION


# Necessary variables
EXPECTED_ARGUMENTS=1

# Check if more/less than the expected number of arguments have been supplied 
# at the command line. If yes, print an error message (help text) and exit
if [ $# -ne $EXPECTED_ARGUMENTS ]
then
  echo
  echo "  Usage: `basename $0` GNUPLOT_VERSION"
  echo "   e.g.: `basename $0` 4.6.4"
  echo
  exit
fi

# Additional variables
GNUPLOT_VERSION="$1"
COMPILER="gcc"
COMPILER_VERSION="4.4.6"
CC="gcc"
CXX="g++"
FC="gfortran"
F77="gfortran"
TODAY=`/bin/date +"%Y%m%d_%H%M%S"`

# Installation specific variables
GNUPLOT_SOURCE="gnuplot-$GNUPLOT_VERSION.tar.gz"
GNUPLOT_INSTALL="$HOME/local/gnuplot/$GNUPLOT_VERSION/$COMPILER/$COMPILER_VERSION"
GNUPLOT_WEBSITE="http://sourceforge.net/projects/gnuplot/files/gnuplot"

# Check if the source code (gnuplot-GNUPLOT_VERSION.tar.gz) already exists in 
# the current folder. If yes, use it. If not, download it
if [ ! -e "${GNUPLOT_SOURCE}" ]
then
  wget $GNUPLOT_WEBSITE/$GNUPLOT_VERSION/$GNUPLOT_SOURCE
fi

# Create the installation location (must be writable)
mkdir -p $GNUPLOT_INSTALL

# Create a temporary folder and extract GNUPlot source code
mkdir ./tmp
cd ./tmp
tar -zxvf ../$GNUPLOT_SOURCE

# Run configure, make clean, make, make install
cd gnuplot-${GNUPLOT_VERSION}/
./configure --prefix=$GNUPLOT_INSTALL 2>&1 | tee configure_$TODAY.txt
make clean                            2>&1 | tee make-clean_$TODAY.txt
make                                  2>&1 | tee make_$TODAY.txt
make install                          2>&1 | tee make-install_$TODAY.txt

# Remove ./tmp
cd ../../
\rm -r ./tmp

# Create symbolic link in $HOME/bin
mkdir -p $HOME/bin
cd $HOME/bin
ln -sf $GNUPLOT_INSTALL/bin/gnuplot gnuplot
echo
