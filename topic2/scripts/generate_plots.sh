#!/bin/bash

# Generate Heat Transfer Visualizations

echo "📊 Generating heat transfer visualizations..."

# Check if gnuplot is installed
if ! command -v gnuplot &> /dev/null; then
    echo "❌ gnuplot not found. Installing via brew..."
    brew install gnuplot
fi

# Generate static plots
echo "🖼️  Creating static plots..."
gnuplot scripts/static_plots.gp

# Generate animation
echo "🎬 Creating animation..."
gnuplot scripts/animation.gp

echo "✅ Visualizations complete!"
echo "📁 Generated files:"
echo "  - res/heat_initial.png"
echo "  - res/heat_final.png" 
echo "  - res/heat_transfer_animation.gif"
