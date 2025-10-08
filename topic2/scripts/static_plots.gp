#!/usr/bin/env gnuplot

# Generate static heat transfer plots
# Usage: gnuplot scripts/static_plots.gp

set terminal png size 800,600
set output 'res/heat_initial.png'
set title 'Initial Temperature Field (t=0)'
set xlabel 'X'
set ylabel 'Y'
set cblabel 'Temperature'
plot 'res/out/out_0.data' with image

set output 'res/heat_final.png'
set title 'Final Temperature Field (t=10000)'
plot 'res/out/out_9900.data' with image

print "Static plots generated:"
print "- res/heat_initial.png"
print "- res/heat_final.png"
