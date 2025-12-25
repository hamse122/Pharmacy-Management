# PythonAnywhere Deployment Guide - Quick Start

## Quick Deployment Steps

### 1. Clone Repository and Setup

Open a **Bash console** in PythonAnywhere and run:

```bash
cd ~
git clone https://github.com/hamse122/Pharmacy-Management.git pms
cd pms
python3.10 -m venv venv
source venv/bin/activate
pip install --user -r requirements.txt
```

### 2. Generate Secret Key and Create .env File

```bash
# Generate secret key
python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
```

Copy the generated key, then create `.env` file in the Files tab at `/home/xamse/pms/.env`:

```
SECRET_KEY=paste-your-generated-key-here
DEBUG=False
ALLOWED_HOSTS=xamse.pythonanywhere.com
```

### 3. Run Database Migrations

```bash
cd ~/pms
source venv/bin/activate
python manage.py migrate
python manage.py createsuperuser
python manage.py collectstatic --noinput
```

### 4. Configure Web App

1. Go to **Web** tab
2. Click **"Add a new web app"**
3. Choose **Manual configuration** → **Python 3.10**
4. Click through the setup

### 5. Update WSGI Configuration

In the **Web** tab, click on the **WSGI configuration file** link and replace with:

```python
import os
import sys

path = '/home/xamse/pms'
if path not in sys.path:
    sys.path.insert(0, path)

os.environ['DJANGO_SETTINGS_MODULE'] = 'pms.settings'

from dotenv import load_dotenv
load_dotenv(os.path.join(path, '.env'))

from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()
```

### 6. Configure Static Files

In the **Web** tab, scroll to **Static files** section:

- **URL:** `/static/` → **Directory:** `/home/xamse/pms/staticfiles`
- **URL:** `/media/` → **Directory:** `/home/xamse/pms/media`

### 7. Reload Web App

Click the green **Reload** button in the Web tab.

Your app will be live at: **https://xamse.pythonanywhere.com**

---

## Troubleshooting

### If static files don't load:
- Make sure you ran `collectstatic`
- Verify static files mapping in Web tab
- Check that `STATIC_ROOT` path is correct

### If you get import errors:
- Verify virtual environment is activated
- Check that all packages are installed: `pip install --user -r requirements.txt`
- Ensure path in WSGI file is correct: `/home/xamse/pms`

### If database errors occur:
- Run migrations again: `python manage.py migrate`
- Check database file permissions

