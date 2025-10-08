#!/bin/bash

# IGA-ADS Heat Transfer Simulation Setup Script

echo "🚀 Setting up IGA-ADS Heat Transfer Simulation..."

# Create necessary directories
mkdir -p res/out

# Clone IGA-ADS repository if not exists
if [ ! -d "iga-ads" ]; then
    echo "📥 Cloning IGA-ADS repository..."
    git clone https://github.com/IGA-ADS/iga-ads.git
else
    echo "✅ IGA-ADS repository already exists"
fi

# Apply necessary fixes to the IGA-ADS repository
echo "🔧 Applying necessary fixes..."

# Replace Containerfile with our Docker-compatible Dockerfile
cd iga-ads/
cp ../scripts/Dockerfile ./Dockerfile

# Fix install-dependencies.sh for macOS sed compatibility
sed -i '' 's/sed -i '\''36i #include <optional>'\''/sed -i '\'''\'' '\''36i\\\n#include <optional>'\''/' scripts/install-dependencies.sh

cd ..

# Check if project is already built
if [ -f "iga-ads/build/examples/heat_2d" ]; then
    echo "✅ IGA-ADS project already built"
else
    echo "🐳 Building Docker image..."
    cd iga-ads/
    docker build -t iga-ads:latest .
    cd ..
fi

echo "✅ Setup complete!"
echo ""
echo "To run the simulation:"
echo "  ./run_simulation.sh"
echo ""
echo "To generate visualizations:"
echo "  ./generate_plots.sh"
