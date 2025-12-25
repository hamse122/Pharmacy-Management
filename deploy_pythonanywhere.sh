#!/bin/bash
# PythonAnywhere Deployment Script
# Run this in your PythonAnywhere Bash console

echo "=== PythonAnywhere Deployment Script ==="
echo ""

# Step 1: Clone repository
echo "Step 1: Cloning repository..."
cd ~
if [ -d "pms" ]; then
    echo "Directory pms already exists. Removing it..."
    rm -rf pms
fi
git clone https://github.com/hamse122/Pharmacy-Management.git pms
cd pms
echo "Repository cloned successfully!"
echo ""

# Step 2: Create virtual environment
echo "Step 2: Creating virtual environment..."
python3.10 -m venv venv
source venv/bin/activate
echo "Virtual environment created and activated!"
echo ""

# Step 3: Install dependencies
echo "Step 3: Installing dependencies..."
pip install --user -r requirements.txt
echo "Dependencies installed!"
echo ""

# Step 4: Generate secret key
echo "Step 4: Generating secret key..."
SECRET_KEY=$(python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())")
echo "Your SECRET_KEY is: $SECRET_KEY"
echo "Please save this and add it to your .env file!"
echo ""

# Step 5: Create .env file template
echo "Step 5: Creating .env file template..."
cat > .env << EOF
SECRET_KEY=$SECRET_KEY
DEBUG=False
ALLOWED_HOSTS=xamse.pythonanywhere.com
EOF
echo ".env file created with generated SECRET_KEY!"
echo ""

# Step 6: Run migrations
echo "Step 6: Running migrations..."
python manage.py migrate
echo "Migrations completed!"
echo ""

# Step 7: Collect static files
echo "Step 7: Collecting static files..."
python manage.py collectstatic --noinput
echo "Static files collected!"
echo ""

echo "=== Deployment Script Completed ==="
echo ""
echo "Next steps:"
echo "1. Create a superuser: python manage.py createsuperuser"
echo "2. Go to Web tab and configure your web app"
echo "3. Update WSGI file with the configuration from README.md"
echo "4. Configure static files mapping in Web tab"
echo "5. Reload your web app"

