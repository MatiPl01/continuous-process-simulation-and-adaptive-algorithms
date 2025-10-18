#!/usr/bin/env gnuplot

# Generate heat transfer animation
# Usage: gnuplot -c heat_animation.gp <time_step> <input_dir> <output_file>
# Example: gnuplot -c heat_animation.gp 1e-5 topic2/res/out/heat_2d_1e-5 topic2/res/heat_2d_1e-5.gif

# Get command line arguments
time_step = ARG1
input_dir = ARG2
output_file = ARG3
title_text = sprintf('Heat Transfer Simulation - Time Step: %s', time_step)

set terminal gif animate delay 20 size 800,600
set output output_file
set title title_text
set xlabel 'X'
set ylabel 'Y'
set cblabel 'Temperature'
set cbrange [0:1]

do for [i=0:9900:100] {
    plot sprintf('%s/out_%d.data', input_dir, i) with image title sprintf('Time step %d', i)
}

print sprintf("Animation generated: %s", output_file)
