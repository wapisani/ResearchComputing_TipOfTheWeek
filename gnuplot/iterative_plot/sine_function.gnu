# sine_function.gnu
# 
# Usage:
# gnuplot sine_function.gnu


set terminal pngcairo size 1280,800 enhanced font 'Helvetica,24'
set output "sine_function.png"
set title  "Iterative plots"
set xlabel "x"
set ylabel "sin(x*n)/n"
set xrange [0:3]
set yrange [-0.6:0.6]
set grid
set style fill transparent solid 0.5 noborder
set sample 500

plot for [n=2:10] sin(x*n)/n notitle with filledcurves
