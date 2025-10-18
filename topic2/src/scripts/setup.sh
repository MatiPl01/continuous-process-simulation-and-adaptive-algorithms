#!/bin/bash

set -e

# Change to project root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/../../.."

echo "🚀 Setting up IGA-ADS Heat Transfer Simulation..."

# Check dependencies
command -v docker >/dev/null 2>&1 || { echo "❌ Docker not found. Install Docker Desktop: https://www.docker.com/products/docker-desktop/"; exit 1; }
command -v git >/dev/null 2>&1 || { echo "❌ Git not found. Install via: brew install git"; exit 1; }
command -v gnuplot >/dev/null 2>&1 || { echo "❌ Gnuplot not found. Install via: brew install gnuplot"; exit 1; }

# Check Docker is running
docker info >/dev/null 2>&1 || { echo "❌ Docker not running. Start Docker Desktop and try again."; exit 1; }

# Create directories
mkdir -p topic2/res/out

# Clone repository if needed
if [ ! -d "iga-ads" ]; then
    echo "📥 Cloning IGA-ADS repository..."
    git clone https://github.com/marcinlos/iga-ads
fi

# Setup Docker
cp topic2/src/Dockerfile iga-ads/Dockerfile

# Build Docker image if needed
if ! docker image inspect iga-ads:latest >/dev/null 2>&1; then
    echo "🐳 Building Docker image (this may take several minutes)..."
    cd iga-ads/
    docker build -t iga-ads:latest .
    cd ..
fi

echo "✅ Setup complete!"
