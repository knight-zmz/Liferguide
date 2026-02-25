#!/bin/bash

# LaTeX Compilation Build Script
# Lifeguide CI/CD Local Helper

set -e

echo "🔨 Liferguide Build System"
echo "=================================="

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Configuration
MAIN_FILE="lifeguide.tex"
OUTPUT_DIR="build"
HTML_DIR="${OUTPUT_DIR}/html"

# === Module 1: XeLaTeX Compilation ===
build_pdf() {
    echo -e "\n${YELLOW}→ Step 1: Compiling LaTeX to PDF...${NC}"
    
    if ! command -v xelatex &> /dev/null; then
        echo -e "${RED}✗ Error: XeLaTeX not found. Please install TeX Live.${NC}"
        exit 1
    fi
    
    # First pass: Generate .toc
    echo "  Pass 1: Building table of contents..."
    xelatex -interaction=nonstopmode -shell-escape "${MAIN_FILE}" > /dev/null || true
    
    # Second pass: Final output with correct page numbers
    echo "  Pass 2: Building final PDF..."
    xelatex -interaction=nonstopmode -shell-escape "${MAIN_FILE}" > /dev/null || true
    
    if [ -f "${MAIN_FILE%.tex}.pdf" ]; then
        echo -e "${GREEN}✓ PDF compiled successfully${NC}"
        echo "  Output: ${MAIN_FILE%.tex}.pdf"
        return 0
    else
        echo -e "${RED}✗ PDF compilation failed${NC}"
        return 1
    fi
}

# === Module 2: HTML Conversion ===
build_html() {
    echo -e "\n${YELLOW}→ Step 2: Converting to HTML...${NC}"
    
    # tex4ht is optional
    if ! command -v make4ht &> /dev/null; then
        echo -e "${YELLOW}⊘ Warning: tex4ht not found. Skipping HTML conversion.${NC}"
        echo "  Install: apt-get install tex4ht (Linux) or brew install tex4ht (macOS)"
        return 0
    fi
    
    mkdir -p "${HTML_DIR}"
    echo "  Converting with tex4ht..."
    
    make4ht -d "${HTML_DIR}" "${MAIN_FILE}" "html5" 2>/dev/null || true
    
    if [ -f "${HTML_DIR}/${MAIN_FILE%.tex}.html" ]; then
        echo -e "${GREEN}✓ HTML conversion successful${NC}"
        echo "  Output: ${HTML_DIR}/${MAIN_FILE%.tex}.html"
    else
        echo -e "${YELLOW}⊘ HTML conversion skipped or incomplete${NC}"
    fi
}

# === Module 3: Build Directory Setup ===
setup_build_dir() {
    echo -e "\n${YELLOW}→ Step 3: Setting up build directory...${NC}"
    
    mkdir -p "${OUTPUT_DIR}"
    cp "${MAIN_FILE%.tex}.pdf" "${OUTPUT_DIR}/" 2>/dev/null || true
    
    echo -e "${GREEN}✓ Build directory prepared${NC}"
}

# === Module 4: Clean Function ===
clean() {
    echo -e "\n${YELLOW}→ Cleaning temporary files...${NC}"
    
    rm -f *.aux *.log *.out *.toc *.fls *.fdb_latexmk *.synctex.gz
    rm -f *.dvi *.ps
    
    echo -e "${GREEN}✓ Temporary files cleaned${NC}"
}

# === Module 5: Help Function ===
show_help() {
    cat << EOF

Usage: ./build.sh [command]

Commands:
  pdf       Build PDF only
  html      Build HTML only  
  all       Build both PDF and HTML (default)
  clean     Remove temporary compilation files
  help      Show this help message

Examples:
  ./build.sh pdf           # Compile PDF
  ./build.sh all           # Full build
  ./build.sh clean         # Clean temp files

Requirements:
  - XeLaTeX (required): apt-get install texlive-xetex
  - tex4ht (optional):   apt-get install tex4ht

For Windows (PowerShell):
  Use build.ps1 instead of this script

EOF
}

# === Main Execution ===
main() {
    case "${1:-all}" in
        pdf)
            build_pdf
            clean
            ;;
        html)
            build_html
            ;;
        all)
            build_pdf && build_html && setup_build_dir
            clean
            echo -e "\n${GREEN}════════════════════════════════${NC}"
            echo -e "${GREEN}✓ Build completed successfully!${NC}"
            echo -e "${GREEN}════════════════════════════════${NC}"
            ;;
        clean)
            clean
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            echo -e "${RED}Unknown command: $1${NC}"
            show_help
            exit 1
            ;;
    esac
}

# Run main function
main "$@"
