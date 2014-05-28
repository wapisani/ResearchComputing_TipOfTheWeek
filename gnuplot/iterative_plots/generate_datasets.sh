#! /bin/bash
#
# BASH script to generate the necessary data files (dataset_i.dat) for use
# with 'iterative_plot_datasets.gnu'.
# 
# Amdahl's law:
# S = 1/((1 - P) + (P/N)) 
# S: Speed up
# P: Parallelizable fraction of the code
# N: Number of processors
#
# Usage:
# generate_datasets.sh

# Parallel fraction array
PARALLEL_FRACTION="0.25 0.50 0.75 0.80 0.85 0.90 0.95"

j=1
for pfrac in $PARALLEL_FRACTION
do
  I=16
  i=0
  echo "NPROC P=$pfrac" > dataset_${j}.dat
  while [ $i -le $I ]
  do
    proc=`echo "2^$i" | bc`
    speed_up=`echo "1/((1 - $pfrac) + ($pfrac / $proc))" | bc -l`
    printf "%-5d  %s\n" "$proc" "$speed_up" >> dataset_${j}.dat
    i=`expr $i + 1`
  done
  j=`expr $j + 1`
done
