# iterative_plot_datasets.gnu
# 
# Usage:
# gnuplot iterative_plot_datasets.gnu


set terminal pngcairo size 1280,800 enhanced font 'Helvetica,24'
set output "iterative_plot_datasets.png"
set title  "Multiple data sets"
set xlabel "x"
set ylabel "sin(x*n)/n"
set xrange [0.00:6.28]
set yrange [-1.1:1.1]
set grid
set style fill transparent solid 0.25 noborder
set sample 1000

plot for [n=1:5] sin(x*n)/n notitle with filledcurves
