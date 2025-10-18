#!/bin/bash

# Heat Transfer Simulation Script
# Usage: ./run_heat_simulation.sh <time_step>
# Example: ./run_heat_simulation.sh 1e-5

set -e

# Global variables for cleanup
CONTAINER_ID=""
ORIGINAL_FILE_RESTORED=false

# Cleanup function
cleanup() {
    if [ ! -z "$CONTAINER_ID" ] && [ "$ORIGINAL_FILE_RESTORED" = false ]; then
        docker exec $CONTAINER_ID bash -c "cd /code/examples/heat && git checkout -- heat_2d.cpp" 2>/dev/null || true
    fi
    if [ ! -z "$CONTAINER_ID" ]; then
        docker stop $CONTAINER_ID >/dev/null 2>&1 || true
        docker rm $CONTAINER_ID >/dev/null 2>&1 || true
    fi
}

trap cleanup EXIT INT TERM

# Check arguments
if [ $# -ne 1 ]; then
    echo "Usage: $0 <time_step>"
    echo "Example: $0 1e-5"
    exit 1
fi

TIME_STEP="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/../../.."

# Validate time step
if ! [[ "$TIME_STEP" =~ ^[0-9]+\.?[0-9]*[eE][+-]?[0-9]+$ ]] && ! [[ "$TIME_STEP" =~ ^[0-9]+\.?[0-9]*$ ]]; then
    echo "Invalid time step format. Use scientific notation (e.g., 1e-5) or decimal (e.g., 0.00001)"
    exit 1
fi

# Setup
OUTPUT_DIR="topic2/res/out/heat_2d_${TIME_STEP}"
mkdir -p "$OUTPUT_DIR"

# Check dependencies
if [ ! -d "iga-ads" ] || ! docker image inspect iga-ads:latest >/dev/null 2>&1; then
    echo "Missing dependencies. Run setup.sh first."
    exit 1
fi

# Run simulation
echo "Running simulation with time step: $TIME_STEP"
CONTAINER_ID=$(docker run -d iga-ads:latest sleep 3600)

# Modify and build
docker exec $CONTAINER_ID bash -c "cd /code/examples/heat && sed -i 's/ads::timesteps_config steps{10000, 1e-5};/ads::timesteps_config steps{10000, $TIME_STEP};/' heat_2d.cpp"
docker exec $CONTAINER_ID bash -c "cd /code && export DEPS=/deps && cmake -S . -B build -D CMAKE_BUILD_TYPE=Release -D ADS_USE_GALOIS=ON -D USE_MUMPS=OFF -D CMAKE_PREFIX_PATH=\"\${DEPS}\" && ninja -C build"

# Run simulation and copy results
docker exec $CONTAINER_ID bash -c "cd /code/build && ./examples/heat_2d"
docker exec $CONTAINER_ID bash -c "cd /code/build && tar czf - out_*.data" | tar xzf - -C "$OUTPUT_DIR/"

# Generate animation
gnuplot -c topic2/src/heat_animation.gp "$TIME_STEP" "$OUTPUT_DIR" "topic2/res/heat_2d_${TIME_STEP}.gif"

ORIGINAL_FILE_RESTORED=true

echo "Complete! Results:"
echo "  Output: $OUTPUT_DIR/"
echo "  Animation: topic2/res/heat_2d_${TIME_STEP}.gif"
