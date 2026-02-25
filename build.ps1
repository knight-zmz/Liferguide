# LaTeX Compilation Build Script for Windows PowerShell
# Lifeguide CI/CD Local Helper

$ErrorActionPreference = "Continue"

# Configuration
$MAIN_FILE = "lifeguide.tex"
$OUTPUT_DIR = "build"
$HTML_DIR = "$OUTPUT_DIR\html"

# Colors
$GREEN = "`e[32m"
$YELLOW = "`e[33m"
$RED = "`e[31m"
$NC = "`e[0m"

function Write-Status {
    param([string]$Message, [string]$Color = "White")
    Write-Host $Message -ForegroundColor $Color
}

# === Module 1: XeLaTeX Compilation ===
function Build-PDF {
    Write-Status "`n→ Step 1: Compiling LaTeX to PDF..." "Yellow"
    
    if (-not (Get-Command xelatex -ErrorAction SilentlyContinue)) {
        Write-Status "✗ Error: XeLaTeX not found. Please install TeX Live." "Red"
        exit 1
    }
    
    # First pass
    Write-Status "  Pass 1: Building table of contents..." "White"
    & xelatex -interaction=nonstopmode -shell-escape $MAIN_FILE *> $null
    
    # Second pass
    Write-Status "  Pass 2: Building final PDF..." "White"
    & xelatex -interaction=nonstopmode -shell-escape $MAIN_FILE *> $null
    
    $pdf_name = $MAIN_FILE -replace '\.tex$', '.pdf'
    if (Test-Path $pdf_name) {
        Write-Status "✓ PDF compiled successfully" "Green"
        Write-Status "  Output: $pdf_name" "White"
        return $true
    } else {
        Write-Status "✗ PDF compilation failed" "Red"
        return $false
    }
}

# === Module 2: HTML Conversion ===
function Build-HTML {
    Write-Status "`n→ Step 2: Converting to HTML..." "Yellow"
    
    if (-not (Get-Command make4ht -ErrorAction SilentlyContinue)) {
        Write-Status "⊘ Warning: tex4ht not found. Skipping HTML conversion." "Yellow"
        Write-Status "  Install: choco install tex4ht OR download from ctan.org" "White"
        return $true
    }
    
    if (-not (Test-Path $HTML_DIR)) {
        New-Item -ItemType Directory -Force -Path $HTML_DIR > $null
    }
    
    Write-Status "  Converting with tex4ht..." "White"
    & make4ht -d $HTML_DIR $MAIN_FILE "html5" *> $null
    
    $html_name = "$HTML_DIR\$($MAIN_FILE -replace '\.tex$', '.html')"
    if (Test-Path $html_name) {
        Write-Status "✓ HTML conversion successful" "Green"
        Write-Status "  Output: $html_name" "White"
    } else {
        Write-Status "⊘ HTML conversion incomplete" "Yellow"
    }
    
    return $true
}

# === Module 3: Build Directory Setup ===
function Setup-BuildDir {
    Write-Status "`n→ Step 3: Setting up build directory..." "Yellow"
    
    if (-not (Test-Path $OUTPUT_DIR)) {
        New-Item -ItemType Directory -Force -Path $OUTPUT_DIR > $null
    }
    
    $pdf_name = $MAIN_FILE -replace '\.tex$', '.pdf'
    if (Test-Path $pdf_name) {
        Copy-Item $pdf_name -Destination "$OUTPUT_DIR\" -Force
    }
    
    Write-Status "✓ Build directory prepared" "Green"
}

# === Module 4: Clean Function ===
function Invoke-Clean {
    Write-Status "`n→ Cleaning temporary files..." "Yellow"
    
    Remove-Item -Force -ErrorAction SilentlyContinue -Path @(
        "*.aux", "*.log", "*.out", "*.toc", "*.fls", "*.fdb_latexmk",
        "*.synctex.gz", "*.dvi", "*.ps"
    )
    
    Write-Status "✓ Temporary files cleaned" "Green"
}

# === Module 5: Help Function ===
function Show-Help {
    $help_text = @"

Usage: .\build.ps1 [-Command] <command>

Commands:
  pdf       Build PDF only
  html      Build HTML only  
  all       Build both PDF and HTML (default)
  clean     Remove temporary compilation files
  help      Show this help message

Examples:
  .\build.ps1 -Command pdf           # Compile PDF
  .\build.ps1 -Command all           # Full build
  .\build.ps1 -Command clean         # Clean temp files

Requirements:
  - XeLaTeX (required): 
    * Windows: Install from https://tug.org/texlive/ 
    * Or: choco install texlive (via Chocolatey)
  
  - tex4ht (optional):   
    * choco install tex4ht
    * Or: https://www.tug.org/tex4ht/

For Linux/macOS:
  Use build.sh instead of this script

"@
    Write-Host $help_text
}

# === Main Execution ===
param(
    [ValidateSet("pdf", "html", "all", "clean", "help")]
    [string]$Command = "all"
)

Write-Status "`n🔨 Liferguide Build System (PowerShell)" "Green"
Write-Status "==================================" "Green"

switch ($Command) {
    "pdf" {
        if (Build-PDF) {
            Invoke-Clean
        }
    }
    "html" {
        Build-HTML
    }
    "all" {
        if (Build-PDF) {
            Build-HTML
            Setup-BuildDir
            Invoke-Clean
            Write-Status "`n════════════════════════════════" "Green"
            Write-Status "✓ Build completed successfully!" "Green"
            Write-Status "════════════════════════════════" "Green"
        }
    }
    "clean" {
        Invoke-Clean
    }
    "help" {
        Show-Help
    }
}
