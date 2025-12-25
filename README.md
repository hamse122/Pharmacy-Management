# Pharmacy Management System (PMS)

A Django-based Pharmacy Management System with employee accounts, payroll, attendance, and pharmacy inventory management.

## Features

- Employee account management
- Payroll and attendance tracking
- Leave management
- Pharmacy inventory management
- Supplier management
- Patient records
- Prescription management
- Billing and sales

## Prerequisites

- Python 3.8 or higher
- pip (Python package installer)

## Local Development Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd omar/pms
```

2. Create a virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

4. Create a `.env` file in the `pms` directory with the following variables:
```
SECRET_KEY=your-secret-key-here
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1
```

5. Run migrations:
```bash
python manage.py migrate
```

6. Create a superuser:
```bash
python manage.py createsuperuser
```

7. Collect static files:
```bash
python manage.py collectstatic
```

8. Run the development server:
```bash
python manage.py runserver
```

## Deployment on PythonAnywhere

### Step 1: Upload Your Project

1. Log in to your PythonAnywhere account
2. Open the **Files** tab
3. Upload your project files (you can use Git or upload directly)
4. Make sure your project structure is:
   ```
   /home/yourusername/
       pms/
           manage.py
           pms/
           accounts/
           pharmacy/
           requirements.txt
           ...
   ```

### Step 2: Set Up Virtual Environment

1. Open a **Bash console** in PythonAnywhere
2. Navigate to your project directory:
   ```bash
   cd ~/pms
   ```
3. Create a virtual environment:
   ```bash
   python3.10 -m venv venv
   ```
   (Use Python 3.10 or the version available on PythonAnywhere)
4. Activate the virtual environment:
   ```bash
   source venv/bin/activate
   ```
5. Install dependencies:
   ```bash
   pip install --user -r requirements.txt
   ```

### Step 3: Configure Environment Variables

1. In the **Files** tab, create a `.env` file in your `pms` directory
2. Add the following content (replace with your actual values):
   ```
   SECRET_KEY=your-production-secret-key-here
   DEBUG=False
   ALLOWED_HOSTS=yourusername.pythonanywhere.com
   ```
3. Generate a new secret key:
   ```bash
   python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
   ```

### Step 4: Set Up Database

1. In the Bash console, run migrations:
   ```bash
   cd ~/pms
   source venv/bin/activate
   python manage.py migrate
   ```
2. Create a superuser:
   ```bash
   python manage.py createsuperuser
   ```

### Step 5: Collect Static Files

1. In the Bash console:
   ```bash
   python manage.py collectstatic --noinput
   ```

### Step 6: Configure Web App

1. Go to the **Web** tab in PythonAnywhere
2. Click **Add a new web app**
3. Choose **Manual configuration** and select your Python version
4. In the **WSGI configuration file** section, click on the file link
5. Replace the content with:
   ```python
   import os
   import sys

   # Add your project directory to the path
   path = '/home/yourusername/pms'
   if path not in sys.path:
       sys.path.insert(0, path)

   # Set the Django settings module
   os.environ['DJANGO_SETTINGS_MODULE'] = 'pms.settings'

   # Load environment variables
   from dotenv import load_dotenv
   load_dotenv(os.path.join(path, '.env'))

   # Get the WSGI application
   from django.core.wsgi import get_wsgi_application
   application = get_wsgi_application()
   ```
   **Important:** Replace `yourusername` with your actual PythonAnywhere username

6. In the **Static files** section:
   - **URL:** `/static/`
   - **Directory:** `/home/yourusername/pms/staticfiles`
   
7. In the **Static files** section (for media):
   - **URL:** `/media/`
   - **Directory:** `/home/yourusername/pms/media`

### Step 7: Reload Web App

1. Click the green **Reload** button in the Web tab
2. Your application should now be live at `https://yourusername.pythonanywhere.com`

## Important Notes for PythonAnywhere

- **Database:** The project uses SQLite by default. For production, consider using MySQL (available on PythonAnywhere)
- **Media Files:** User-uploaded files are stored in the `media` directory. Make sure to configure the static files mapping correctly
- **Secret Key:** Never commit your `.env` file with the actual secret key to version control
- **Debug Mode:** Always set `DEBUG=False` in production
- **Allowed Hosts:** Make sure to include your PythonAnywhere domain in `ALLOWED_HOSTS`

## Project Structure

```
pms/
├── accounts/          # Employee accounts, payroll, attendance
├── pharmacy/          # Pharmacy inventory and management
├── pms/              # Django project settings
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
├── media/            # User uploaded files
├── static/           # Static files (CSS, JS, images)
├── staticfiles/      # Collected static files (generated)
├── manage.py
└── requirements.txt
```

## Troubleshooting

### Static files not loading
- Make sure you've run `python manage.py collectstatic`
- Verify the static files mapping in the Web tab
- Check that `STATIC_ROOT` is set correctly in settings.py

### Database errors
- Ensure migrations have been run: `python manage.py migrate`
- Check database file permissions if using SQLite

### Import errors
- Verify your virtual environment is activated
- Check that all dependencies are installed: `pip install -r requirements.txt`
- Ensure your project path is correct in the WSGI file

## License

[Your License Here]

## Support

For issues and questions, please contact [your contact information]

