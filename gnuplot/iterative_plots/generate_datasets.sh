#! /bin/bash

BASES="5000 3000 1000 700 300"
PROCS="1 2 4 8 16 32 64 128"

i=1
for base in $BASES
do
  truncate -s0 dataset_${i}.dat
  for proc in $PROCS
  do
    measured_value=`echo "$proc * $base" | bc`
    random_number=$(( $RANDOM % 100 ))
    y_axis_value=`echo "$measured_value - $random_number" | bc`
    printf "%-3d  %6d  %6d\n" "$proc" "$measured_value" "$y_axis_value"
    printf "%-3d  %6d\n" "$proc" "$y_axis_value" >> dataset_${i}.dat
  done
  i=`expr $i + 1`
done
