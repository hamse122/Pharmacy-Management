# Complete PythonAnywhere Deployment Guide

Follow these steps **in order** to deploy your Pharmacy Management System on PythonAnywhere.

---

## Prerequisites Checklist

- [ ] PythonAnywhere account created (username: xamse)
- [ ] GitHub repository accessible (git@github.com:hamse122/Pharmacy-Management.git)
- [ ] Bash console open in PythonAnywhere

---

## PART 1: Clone and Setup Project

### Step 1: Clone Repository

In your **Bash console**, run:

```bash
cd ~
git clone git@github.com:hamse122/Pharmacy-Management.git pms
cd pms
```

**If you get SSH key error:**
```bash
# Generate SSH key
ssh-keygen -t ed25519 -C "your_email@example.com"
# Press Enter 3 times (accept defaults, no passphrase)

# Display public key
cat ~/.ssh/id_ed25519.pub
```

Then:
1. Copy the displayed key
2. Go to GitHub → Settings → SSH and GPG keys → New SSH key
3. Paste key and save
4. Try cloning again

### Step 2: Verify Project Structure

```bash
ls -la
```

You should see: `manage.py`, `requirements.txt`, `pms/`, `accounts/`, `pharmacy/`, etc.

### Step 3: Create Virtual Environment

```bash
python3.10 -m venv venv
source venv/bin/activate
```

You should see `(venv)` in your prompt.

### Step 4: Install Dependencies

```bash
pip install --user -r requirements.txt
```

This may take a few minutes. Wait for it to complete.

---

## PART 2: Configure Environment Variables

### Step 5: Generate Secret Key

```bash
python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
```

**IMPORTANT:** Copy the entire output (it's a long string). You'll need it in the next step.

### Step 6: Create .env File

1. Open a **new tab** and go to PythonAnywhere **Files** tab
2. Navigate to: `/home/xamse/pms/`
3. Click **"New file"** button
4. Name it exactly: `.env` (with the dot at the beginning)
5. Paste this content (replace `YOUR_SECRET_KEY` with the key from Step 5):

```
SECRET_KEY=YOUR_SECRET_KEY
DEBUG=False
ALLOWED_HOSTS=xamse.pythonanywhere.com
```

6. Click **Save**

**Example:**
```
SECRET_KEY=django-insecure-abc123xyz789...
DEBUG=False
ALLOWED_HOSTS=xamse.pythonanywhere.com
```

---

## PART 3: Database Setup

### Step 7: Run Migrations

Go back to your **Bash console** and run:

```bash
cd ~/pms
source venv/bin/activate
python manage.py migrate
```

You should see output like:
```
Operations to perform:
  Apply all migrations: ...
Running migrations:
  ...
```

### Step 8: Create Superuser (Admin Account)

```bash
python manage.py createsuperuser
```

Follow the prompts:
- Username: (enter your admin username)
- Email address: (enter your email)
- Password: (enter a strong password)
- Password (again): (confirm password)

**Save these credentials!** You'll need them to access the admin panel.

---

## PART 4: Static Files Setup

### Step 9: Collect Static Files

```bash
python manage.py collectstatic --noinput
```

This will create a `staticfiles` directory with all CSS, JS, and images.

---

## PART 5: Configure Web App

### Step 10: Create Web App

1. Go to **Web** tab in PythonAnywhere
2. Click **"Add a new web app"** button
3. Select **"Manual configuration"**
4. Select **Python 3.10**
5. Click **Next**
6. Click **Next** again
7. Click **"All done!"**

### Step 11: Configure WSGI File

1. In the **Web** tab, find **"WSGI configuration file"** section
2. Click on the file link (it will be something like `/var/www/xamse_pythonanywhere_com_wsgi.py`)
3. **Delete all existing content**
4. Copy and paste this **exact** code:

```python
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
```

5. Click **Save**

### Step 12: Configure Static Files Mapping

Still in the **Web** tab, scroll down to **"Static files"** section:

1. In the first row:
   - **URL:** `/static/`
   - **Directory:** `/home/xamse/pms/staticfiles`
   - Click **Add**

2. In the second row:
   - **URL:** `/media/`
   - **Directory:** `/home/xamse/pms/media`
   - Click **Add**

### Step 13: Reload Web App

1. Scroll to the top of the **Web** tab
2. Click the green **"Reload"** button
3. Wait for it to reload (you'll see a success message)

---

## PART 6: Verify Deployment

### Step 14: Test Your Application

1. Your app should now be live at: **https://xamse.pythonanywhere.com**
2. Open it in a new browser tab
3. You should see your Django application homepage

### Step 15: Access Admin Panel

1. Go to: **https://xamse.pythonanywhere.com/admin/**
2. Log in with the superuser credentials you created in Step 8

---

## Troubleshooting

### Problem: Static files not loading

**Solution:**
```bash
cd ~/pms
source venv/bin/activate
python manage.py collectstatic --noinput
```
Then reload the web app.

### Problem: 500 Internal Server Error

**Solution:**
1. Go to **Web** tab → **Error log** section
2. Check the error message
3. Common issues:
   - Missing `.env` file → Create it (Step 6)
   - Wrong path in WSGI → Check Step 11
   - Missing dependencies → Run `pip install --user -r requirements.txt` again

### Problem: Import errors

**Solution:**
```bash
cd ~/pms
source venv/bin/activate
pip install --user -r requirements.txt
```
Then reload the web app.

### Problem: Database errors

**Solution:**
```bash
cd ~/pms
source venv/bin/activate
python manage.py migrate
```
Then reload the web app.

### Problem: Can't access admin panel

**Solution:**
Make sure you created a superuser:
```bash
cd ~/pms
source venv/bin/activate
python manage.py createsuperuser
```

---

## Quick Reference Commands

If you need to restart or fix something, use these commands:

```bash
# Navigate to project
cd ~/pms

# Activate virtual environment
source venv/bin/activate

# Install/update dependencies
pip install --user -r requirements.txt

# Run migrations
python manage.py migrate

# Collect static files
python manage.py collectstatic --noinput

# Create superuser
python manage.py createsuperuser

# Check Django version
python manage.py version
```

---

## Deployment Checklist

Use this to track your progress:

- [ ] Repository cloned successfully
- [ ] Virtual environment created and activated
- [ ] Dependencies installed
- [ ] Secret key generated
- [ ] .env file created with correct values
- [ ] Migrations run successfully
- [ ] Superuser created
- [ ] Static files collected
- [ ] Web app created in PythonAnywhere
- [ ] WSGI file configured correctly
- [ ] Static files mapping configured
- [ ] Media files mapping configured
- [ ] Web app reloaded
- [ ] Application accessible at https://xamse.pythonanywhere.com
- [ ] Admin panel accessible

---

## Your Application URLs

After successful deployment:

- **Main Application:** https://xamse.pythonanywhere.com
- **Admin Panel:** https://xamse.pythonanywhere.com/admin/
- **API (if configured):** https://xamse.pythonanywhere.com/api/

---

## Next Steps After Deployment

1. **Test all features** of your application
2. **Set up scheduled tasks** (if needed) in the **Tasks** tab
3. **Configure email settings** (if your app sends emails)
4. **Set up database backups** (consider using MySQL for production)
5. **Monitor error logs** regularly in the **Web** tab

---

## Support

If you encounter any issues:
1. Check the **Error log** in the **Web** tab
2. Review the troubleshooting section above
3. Check PythonAnywhere forums: https://www.pythonanywhere.com/forums/

---

**Congratulations! Your Pharmacy Management System should now be live on PythonAnywhere! 🎉**

