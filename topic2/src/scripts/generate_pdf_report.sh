#!/bin/bash

# PDF Report Generation Script
# Converts markdown report to PDF with proper text wrapping

set -e

# Change to project root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/../../.."

echo "📄 Generating PDF report..."

# Check if pandoc is installed
if ! command -v pandoc >/dev/null 2>&1; then
    echo "❌ Pandoc not found. Installing via Homebrew..."
    if command -v brew >/dev/null 2>&1; then
        brew install pandoc
    else
        echo "❌ Homebrew not found. Please install pandoc manually:"
        echo "   https://pandoc.org/installing.html"
        exit 1
    fi
fi

# Check if ImageMagick is available for GIF conversion
if ! command -v convert >/dev/null 2>&1; then
    echo "❌ ImageMagick not found. Installing via Homebrew..."
    if command -v brew >/dev/null 2>&1; then
        brew install imagemagick
    else
        echo "❌ Homebrew not found. Please install ImageMagick manually:"
        echo "   https://imagemagick.org/script/download.php"
        exit 1
    fi
fi

# Check if LaTeX is available (for better PDF generation)
if ! command -v pdflatex >/dev/null 2>&1; then
    echo "⚠️  LaTeX not found. Installing BasicTeX..."
    if command -v brew >/dev/null 2>&1; then
        brew install --cask basictex
        echo "📝 Please run 'sudo tlmgr update --self' and 'sudo tlmgr install collection-fontsrecommended' after installation"
    else
        echo "⚠️  For better PDF generation, install LaTeX manually:"
        echo "   https://www.latex-project.org/get/"
    fi
fi

# Convert GIFs to static images (90% frame)
echo "🖼️  Converting GIFs to static images..."
cd topic2

# Find all GIF files referenced in the markdown
gif_files=$(grep -o 'res/[^)]*\.gif' raport.md | sort -u)

if [ -n "$gif_files" ]; then
    echo "Found GIF files: $gif_files"
    
    for gif_file in $gif_files; do
        if [ -f "$gif_file" ]; then
            echo "Converting $gif_file to PNG (90% frame)..."
            # Get frame count and extract 90% frame
            frame_count=$(magick identify "$gif_file" | wc -l)
            frame_90=$((frame_count * 90 / 100))
            echo "Total frames: $frame_count, Using frame: $frame_90"
            
            # Convert to PNG
            png_file="${gif_file%.gif}.png"
            magick "$gif_file[${frame_90}]" "$png_file"
            echo "✅ Converted: $gif_file → $png_file"
        else
            echo "⚠️  GIF file not found: $gif_file"
        fi
    done
else
    echo "ℹ️  No GIF files found in markdown"
fi

# Generate PDF directly from markdown with inline processing
echo "🔄 Converting markdown to PDF..."

# Generate PDF with better text wrapping and readable font size
echo "📄 Using default PDF engine with better text wrapping..."

sed 's/\.gif/.png/g' raport.md | pandoc -o raport.pdf \
    --variable geometry:margin=1in \
    --variable fontsize=10pt \
    --variable linestretch=1.0 \
    --listings \
    --wrap=auto \
    --columns=60 \
    --include-in-header=src/latex_template.tex \
    --pdf-engine=pdflatex

if [ $? -eq 0 ]; then
    echo "✅ PDF report generated successfully!"
    echo "📁 Location: topic2/raport.pdf"
    echo ""
    echo "📊 Report features:"
    echo "  - Professional formatting"
    echo "  - Syntax highlighting for code blocks"
    echo "  - Proper margins and typography"
    echo "  - Static images (90% frame of GIFs)"
    echo "  - Aggressive text wrapping"
    echo ""
    echo "📖 To view the PDF:"
    echo "  open topic2/raport.pdf"
else
    echo "❌ Failed to generate PDF report"
    exit 1
fi
