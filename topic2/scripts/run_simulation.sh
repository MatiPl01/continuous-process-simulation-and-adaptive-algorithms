#!/bin/bash

# Run IGA-ADS Heat Transfer Simulation

echo "🔥 Running heat transfer simulation..."

# Create output directory
mkdir -p res/out

# Run the simulation directly
cd iga-ads/build/examples
./heat_2d
cp out_*.data ../../../res/out/
cd ../../../..

# Count the generated files
FILE_COUNT=$(ls res/out/*.data 2>/dev/null | wc -l)
echo "✅ Simulation complete! Results saved to res/out/"
echo "📊 Generated $FILE_COUNT data files"
