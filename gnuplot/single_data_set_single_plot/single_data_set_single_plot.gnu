# single_data_set_single_plot.gnu
# 
# Gnuplot instructions to plot the data contained in 
# single_data_set_single_plot.dat.
#
# Usage:
# gnuplot single_data_set_single_plot.gnu


set terminal postscript eps enhanced color "Helvetica" 24
set output "single_data_set_single_plot.eps"
set size 2.0,2.0
set title  "One set of data points from one file"
set xlabel "# of processors"
set ylabel "Time (seconds)"
set xrange [0:18]
set grid
plot 'single_data_set_single_plot.dat' using 1:2 title "# of atoms = 10" with linesp lt 1 pt 5
