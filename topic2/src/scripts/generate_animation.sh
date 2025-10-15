#!/bin/bash

# Heat Transfer Animation Generation Script
# Creates GIF animation from heat_2d simulation data

set -e
cd "$(dirname "$0")/../.."

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --input-dir)
      INPUT_DIR="$2"
      shift 2
      ;;
    --output)
      OUTPUT_FILE="$2"
      shift 2
      ;;
    -h|--help)
      echo "Usage: $0 --input-dir DIR --output FILE"
      echo "  --input-dir DIR   Directory with out_*.data files (required)"
      echo "  --output FILE     Output GIF filename (required)"
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      echo "Use --help for usage information"
      exit 1
      ;;
  esac
done

# Check if required parameters are provided
if [ -z "$INPUT_DIR" ]; then
    echo "❌ Error: --input-dir parameter is required"
    echo "Usage: $0 --input-dir DIR --output FILE"
    echo "Use --help for more information"
    exit 1
fi

if [ -z "$OUTPUT_FILE" ]; then
    echo "❌ Error: --output parameter is required"
    echo "Usage: $0 --input-dir DIR --output FILE"
    echo "Use --help for more information"
    exit 1
fi

echo "🎬 Generowanie animacji heat transfer..."
echo "📁 Katalog wejściowy: $INPUT_DIR"
echo "📄 Plik wyjściowy: $OUTPUT_FILE"

# Check if input data exists
if [ ! -d "$INPUT_DIR" ] || [ -z "$(ls $INPUT_DIR/out_*.data 2>/dev/null)" ]; then
    echo "❌ Brak danych symulacji w $INPUT_DIR"
    echo "Upewnij się, że katalog istnieje i zawiera pliki out_*.data"
    exit 1
fi

# Generate GIF animation using gnuplot with parameters
echo "🎬 Tworzenie animacji GIF..."
gnuplot -e "input_dir='$INPUT_DIR'; output_file='$OUTPUT_FILE'" src/heat_animation.gp

echo "✅ Animacja wygenerowana: $OUTPUT_FILE"
