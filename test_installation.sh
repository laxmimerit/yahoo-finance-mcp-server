#!/bin/bash

# Test Installation Script for Yahoo Finance MCP Server
# This script tests various installation methods

set -e  # Exit on error

echo "======================================"
echo "Yahoo Finance MCP Server - Installation Test"
echo "======================================"
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

success() {
    echo -e "${GREEN}✓ $1${NC}"
}

error() {
    echo -e "${RED}✗ $1${NC}"
}

info() {
    echo -e "${YELLOW}→ $1${NC}"
}

# Test 1: Check uv installation
echo "Test 1: Checking uv installation..."
if command -v uv &> /dev/null; then
    UV_VERSION=$(uv --version)
    success "uv is installed: $UV_VERSION"
else
    error "uv is not installed"
    info "Install with: curl -LsSf https://astral.sh/uv/install.sh | sh"
    exit 1
fi
echo ""

# Test 2: Check Python version
echo "Test 2: Checking Python version..."
PYTHON_VERSION=$(python3 --version 2>&1 | cut -d' ' -f2)
MAJOR=$(echo $PYTHON_VERSION | cut -d'.' -f1)
MINOR=$(echo $PYTHON_VERSION | cut -d'.' -f2)

if [ "$MAJOR" -ge 3 ] && [ "$MINOR" -ge 10 ]; then
    success "Python version is sufficient: $PYTHON_VERSION"
else
    error "Python version is too old: $PYTHON_VERSION (requires 3.10+)"
    exit 1
fi
echo ""

# Test 3: Build the package
echo "Test 3: Building the package..."
info "Cleaning previous builds..."
rm -rf dist/ build/ *.egg-info src/*.egg-info

info "Building with uv..."
if uv build; then
    success "Package built successfully"
    ls -lh dist/
else
    error "Package build failed"
    exit 1
fi
echo ""

# Test 4: Check package contents
echo "Test 4: Checking package contents..."
if [ -f dist/yahoo_finance_mcp_server-0.1.0-py3-none-any.whl ]; then
    success "Wheel file created"
    info "Contents:"
    unzip -l dist/yahoo_finance_mcp_server-0.1.0-py3-none-any.whl | grep -E "\.py$" | head -10
else
    error "Wheel file not found"
    exit 1
fi
echo ""

# Test 5: Install the package locally
echo "Test 5: Installing package locally..."
info "Creating temporary virtual environment..."
TEMP_VENV=$(mktemp -d)
python3 -m venv "$TEMP_VENV"
source "$TEMP_VENV/bin/activate"

info "Installing from wheel..."
if pip install dist/yahoo_finance_mcp_server-0.1.0-py3-none-any.whl; then
    success "Package installed successfully"
else
    error "Package installation failed"
    deactivate
    rm -rf "$TEMP_VENV"
    exit 1
fi
echo ""

# Test 6: Test the command
echo "Test 6: Testing command line interface..."
if command -v yahoo-finance-mcp-server &> /dev/null; then
    success "yahoo-finance-mcp-server command is available"
else
    error "yahoo-finance-mcp-server command not found"
    deactivate
    rm -rf "$TEMP_VENV"
    exit 1
fi
echo ""

# Test 7: Test module import
echo "Test 7: Testing module import..."
if python3 -c "import yahoo_finance_mcp_server; print(yahoo_finance_mcp_server.__version__)"; then
    success "Module imports successfully"
else
    error "Module import failed"
    deactivate
    rm -rf "$TEMP_VENV"
    exit 1
fi
echo ""

# Cleanup
info "Cleaning up temporary environment..."
deactivate
rm -rf "$TEMP_VENV"

# Final summary
echo ""
echo "======================================"
success "All tests passed! ✓"
echo "======================================"
echo ""
echo "Next steps:"
echo "1. Publish to TestPyPI: twine upload --repository testpypi dist/*"
echo "2. Test from TestPyPI: pip install --index-url https://test.pypi.org/simple/ yahoo-finance-mcp"
echo "3. Publish to PyPI: twine upload dist/*"
echo "4. Test with uvx: uvx yahoo-finance-mcp-server"
echo ""
