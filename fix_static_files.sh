#!/bin/bash
# Script to fix static files issues on PythonAnywhere
# Run this in your PythonAnywhere Bash console

echo "=== Fixing Static Files Issues ==="
echo ""

# Get current directory
CURRENT_DIR=$(pwd)
echo "Current directory: $CURRENT_DIR"
echo ""

# Check if we're in the right directory
if [ ! -f "manage.py" ]; then
    echo "ERROR: manage.py not found!"
    echo "Please navigate to your project directory first:"
    echo "  cd ~/Pharmacy-Management"
    echo "  or"
    echo "  cd ~/pms"
    exit 1
fi

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Run collectstatic
echo ""
echo "Running collectstatic..."
python manage.py collectstatic --noinput

# Check if directories exist
echo ""
echo "Checking directories..."
if [ -d "staticfiles" ]; then
    echo "✓ staticfiles/ directory exists"
    echo "  Files in staticfiles: $(ls staticfiles | wc -l)"
else
    echo "✗ staticfiles/ directory NOT found!"
fi

if [ -d "media" ]; then
    echo "✓ media/ directory exists"
    echo "  Files in media: $(ls media | wc -l)"
else
    echo "✗ media/ directory NOT found!"
    echo "  Creating media directory..."
    mkdir -p media
fi

# Set permissions
echo ""
echo "Setting file permissions..."
chmod -R 755 staticfiles/ 2>/dev/null
chmod -R 755 media/ 2>/dev/null

echo ""
echo "=== Done ==="
echo ""
echo "Next steps:"
echo "1. Go to PythonAnywhere Web tab"
echo "2. Configure static files mapping:"
echo "   - URL: /static/ → Directory: $CURRENT_DIR/staticfiles"
echo "   - URL: /media/ → Directory: $CURRENT_DIR/media"
echo "3. Click Reload button"
echo ""

