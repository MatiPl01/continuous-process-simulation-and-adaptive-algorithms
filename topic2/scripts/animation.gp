#!/usr/bin/env gnuplot

# Generate heat transfer animation
# Usage: gnuplot scripts/animation.gp

set terminal gif animate delay 20 size 800,600
set output 'res/heat_transfer_animation.gif'
set title 'Heat Transfer Simulation - Time Evolution'
set xlabel 'X'
set ylabel 'Y'
set cblabel 'Temperature'
set cbrange [0:1]

do for [i=0:9900:100] {
    plot sprintf('res/out/out_%d.data', i) with image title sprintf('Time step %d', i)
}

print "Animation generated: res/heat_transfer_animation.gif"
