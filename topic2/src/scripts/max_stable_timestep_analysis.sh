#!/bin/bash

# IGA-ADS Stability Analysis Script

set -e
cd "$(dirname "$0")/../.."

# Default parameters
TOLERANCE="1e-10"
VERBOSE=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --tolerance)
      TOLERANCE="$2"
      shift 2
      ;;
    --verbose)
      VERBOSE=true
      shift
      ;;
    -h|--help)
      echo "Usage: $0 [--tolerance VALUE] [--verbose]"
      echo "  --tolerance VALUE  Set tolerance for binary search (default: 1e-10)"
      echo "  --verbose          Show detailed binary search steps"
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

echo "🔍 Analiza stabilności czasowej IGA-ADS..."

# Create a persistent container
echo "🐳 Tworzenie kontenera Docker..."
CONTAINER_ID=$(docker run -d iga-ads:latest sleep 3600)
echo "✅ Kontener utworzony: $CONTAINER_ID"

# Copy max stable timestep test to iga-ads project
echo "📁 Kopiowanie testu stabilności do projektu IGA-ADS..."
docker cp src/max_stable_timestep.cpp $CONTAINER_ID:/code/examples/max_stable_timestep.cpp
echo "✅ Plik skopiowany do kontenera"

# Compile and run max stable timestep test
echo "🔨 Kompilacja testu stabilności..."
echo "⚙️ Uruchamianie analizy stabilności..."

# Convert verbose flag to 0/1 format
VERBOSE_FLAG="0"
if [ "$VERBOSE" = true ]; then
  VERBOSE_FLAG="1"
fi

# Run the analysis and capture all output
FULL_OUTPUT=$(docker exec $CONTAINER_ID bash -c "cd /code && g++ -o max_stable_timestep examples/max_stable_timestep.cpp && ./max_stable_timestep $VERBOSE_FLAG $TOLERANCE" 2>&1)

# Get the maximum stable time step
MAX_STABLE_DT=$(echo "$FULL_OUTPUT" | tail -n 1)

# Extract logs (everything except the last line)
STABILITY_LOGS=$(echo "$FULL_OUTPUT" | sed '$d')

# Clean up
echo "🧹 Czyszczenie kontenera..."
docker rm -f $CONTAINER_ID

echo "✅ Analiza stabilności zakończona"
echo ""
echo "📊 WYNIKI ANALIZY:"
echo "$STABILITY_LOGS"
echo ""
echo "🎯 Maksymalny stabilny krok czasowy: $MAX_STABLE_DT"
