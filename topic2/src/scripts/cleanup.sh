#!/bin/bash

# This script removes all build artifacts, Docker images, and temporary files

set -e

# Change to project root directory
cd "$(dirname "$0")/../.."

echo "🧹 Cleaning IGA-ADS project..."

# Remove iga-ads directory
if [ -d "iga-ads" ]; then
    echo "🗑️  Removing iga-ads directory..."
    rm -rf iga-ads
    echo "✅ iga-ads directory removed"
else
    echo "ℹ️  iga-ads directory not found"
fi

# Remove Docker image
if docker image inspect iga-ads:latest >/dev/null 2>&1; then
    echo "🐳 Removing Docker image iga-ads:latest..."
    docker rmi iga-ads:latest
    echo "✅ Docker image removed"
else
    echo "ℹ️  Docker image iga-ads:latest not found"
fi

# Remove entire res directory
if [ -d "res" ]; then
    echo "📁 Removing res directory..."
    rm -rf res
    echo "✅ res directory removed"
else
    echo "ℹ️  res directory not found"
fi

# Clean up any Docker containers that might be running
echo "🐳 Cleaning up Docker containers..."
docker ps -q --filter "ancestor=iga-ads:latest" | xargs -r docker stop 2>/dev/null || true
docker ps -aq --filter "ancestor=iga-ads:latest" | xargs -r docker rm 2>/dev/null || true
echo "✅ Docker containers cleaned"

# Remove any dangling Docker images
echo "🧽 Removing dangling Docker images..."
docker image prune -f >/dev/null 2>&1 || true
echo "✅ Dangling images removed"

echo ""
echo "🎉 Project cleanup complete!"
echo ""
echo "The following have been removed:"
echo "  - iga-ads/ directory"
echo "  - iga-ads:latest Docker image"
echo "  - res/ directory (all outputs and visualizations)"
echo "  - Docker containers and dangling images"
echo ""
echo "To set up the project again, run:"
echo "  ./src/scripts/setup.sh"
