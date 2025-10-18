#!/bin/bash

# This script removes all build artifacts, Docker images, and temporary files

set -e

# Change to project root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/../../.."

echo "🧹 Cleaning IGA-ADS project..."

# Clean up build artifacts in iga-ads directory before removal
if [ -d "iga-ads" ]; then
    echo "🔨 Cleaning build artifacts in iga-ads directory..."
    # Remove build directories
    rm -rf iga-ads/build 2>/dev/null || true
    rm -rf iga-ads/external/build 2>/dev/null || true
    # Remove any generated files
    find iga-ads -name "*.o" -delete 2>/dev/null || true
    find iga-ads -name "*.a" -delete 2>/dev/null || true
    find iga-ads -name "*.so" -delete 2>/dev/null || true
    find iga-ads -name "*.dylib" -delete 2>/dev/null || true
    find iga-ads -name "*.exe" -delete 2>/dev/null || true
    find iga-ads -name "CMakeCache.txt" -delete 2>/dev/null || true
    find iga-ads -name "CMakeFiles" -type d -exec rm -rf {} + 2>/dev/null || true
    echo "✅ Build artifacts cleaned"
    
    echo "🗑️  Removing iga-ads directory..."
    rm -rf iga-ads
    echo "✅ iga-ads directory removed"
else
    echo "ℹ️  iga-ads directory not found"
fi

# Remove Docker image (force remove)
if docker image inspect iga-ads:latest >/dev/null 2>&1; then
    echo "🐳 Force removing Docker image iga-ads:latest..."
    docker rmi -f iga-ads:latest 2>/dev/null || true
    echo "✅ Docker image removed"
else
    echo "ℹ️  Docker image iga-ads:latest not found"
fi

# Remove entire res directory
if [ -d "topic2/res" ]; then
    echo "📁 Removing res directory..."
    rm -rf topic2/res
    echo "✅ res directory removed"
else
    echo "ℹ️  res directory not found"
fi

# Remove generated reports
if [ -f "topic2/raport.md" ]; then
    echo "📄 Removing generated reports..."
    rm -f topic2/raport.md topic2/raport.pdf
    echo "✅ Reports removed"
else
    echo "ℹ️  No reports found"
fi

# Clean up any Docker containers that might be running
echo "🐳 Cleaning up Docker containers..."
# Force stop and remove all containers using iga-ads:latest
docker ps -q --filter "ancestor=iga-ads:latest" | xargs -r docker stop -f 2>/dev/null || true
docker ps -aq --filter "ancestor=iga-ads:latest" | xargs -r docker rm -f 2>/dev/null || true

# Clean up any containers with iga-ads in the name
docker ps -aq --filter "name=iga-ads" | xargs -r docker stop -f 2>/dev/null || true
docker ps -aq --filter "name=iga-ads" | xargs -r docker rm -f 2>/dev/null || true

# Clean up any containers that might be related to this project
docker ps -aq --filter "label=project=iga-ads" | xargs -r docker stop -f 2>/dev/null || true
docker ps -aq --filter "label=project=iga-ads" | xargs -r docker rm -f 2>/dev/null || true

# Also clean up any stopped containers
docker container prune -f >/dev/null 2>&1 || true
echo "✅ Docker containers cleaned"

# Remove any dangling Docker images
echo "🧽 Removing dangling Docker images..."
docker image prune -f >/dev/null 2>&1 || true
echo "✅ Dangling images removed"

# Clean up any Docker networks created for this project
echo "🌐 Cleaning up Docker networks..."
docker network ls --filter "name=iga-ads" -q | xargs -r docker network rm 2>/dev/null || true
echo "✅ Docker networks cleaned"

# Clean up any Docker volumes created for this project
echo "💾 Cleaning up Docker volumes..."
docker volume ls --filter "name=iga-ads" -q | xargs -r docker volume rm 2>/dev/null || true
echo "✅ Docker volumes cleaned"

echo ""
echo "🎉 Project cleanup complete!"
echo ""
echo "The following have been removed:"
echo "  - iga-ads/ directory (including all build artifacts)"
echo "  - iga-ads:latest Docker image"
echo "  - res/ directory (all outputs and visualizations)"
echo "  - Generated reports (raport.md, raport.pdf)"
echo "  - All Docker containers (running and stopped)"
echo "  - All Docker networks and volumes"
echo "  - All dangling Docker images"
echo "  - All build artifacts (*.o, *.a, *.so, CMakeCache.txt, etc.)"
echo ""
echo "To set up the project again, run:"
echo "  ./src/scripts/setup.sh"
