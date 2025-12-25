# WSGI Configuration for PythonAnywhere
# Copy this content to your WSGI configuration file in the Web tab

import os
import sys

# Add your project directory to the path
path = '/home/xamse/pms'
if path not in sys.path:
    sys.path.insert(0, path)

# Set the Django settings module
os.environ['DJANGO_SETTINGS_MODULE'] = 'pms.settings'

# Load environment variables from .env file
from dotenv import load_dotenv
load_dotenv(os.path.join(path, '.env'))

# Get the WSGI application
from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()

