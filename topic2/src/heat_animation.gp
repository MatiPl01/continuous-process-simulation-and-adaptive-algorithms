#!/usr/bin/env gnuplot

# Generate heat transfer animation
# Called from generate_animation.sh script

set terminal gif animate delay 20 size 800,600
set output output_file
set title 'Heat Transfer Simulation - Time Evolution'
set xlabel 'X'
set ylabel 'Y'
set cblabel 'Temperature'
set cbrange [0:1]

do for [i=0:9900:100] {
    plot sprintf('%s/out_%d.data', input_dir, i) with image title sprintf('Time step %d', i)
}

print "Animation generated: " . output_file
