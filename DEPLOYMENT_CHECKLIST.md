# PythonAnywhere Deployment Checklist

Use this checklist to ensure a smooth deployment on PythonAnywhere.

## Pre-Deployment

- [ ] All code changes committed
- [ ] `.env` file created with production values (not committed to git)
- [ ] `DEBUG=False` in production `.env`
- [ ] `ALLOWED_HOSTS` includes your PythonAnywhere domain
- [ ] Secret key generated and set in `.env`
- [ ] Database backup created (if migrating existing data)

## Deployment Steps

### 1. Upload Project
- [ ] Project files uploaded to `/home/yourusername/pms/`
- [ ] Project structure verified

### 2. Virtual Environment
- [ ] Virtual environment created
- [ ] Virtual environment activated
- [ ] All dependencies installed (`pip install -r requirements.txt`)

### 3. Environment Configuration
- [ ] `.env` file created in project root
- [ ] `SECRET_KEY` set in `.env`
- [ ] `DEBUG=False` in `.env`
- [ ] `ALLOWED_HOSTS` set correctly in `.env`

### 4. Database Setup
- [ ] Migrations run (`python manage.py migrate`)
- [ ] Superuser created (`python manage.py createsuperuser`)
- [ ] Database permissions verified

### 5. Static Files
- [ ] Static files collected (`python manage.py collectstatic --noinput`)
- [ ] Static files directory exists: `/home/yourusername/pms/staticfiles/`

### 6. Web App Configuration
- [ ] Web app created in PythonAnywhere dashboard
- [ ] WSGI file configured correctly
- [ ] Static files mapping configured:
  - URL: `/static/` → Directory: `/home/yourusername/pms/staticfiles`
  - URL: `/media/` → Directory: `/home/yourusername/pms/media`
- [ ] Web app reloaded

### 7. Testing
- [ ] Website accessible at `https://yourusername.pythonanywhere.com`
- [ ] Static files loading correctly
- [ ] Media files accessible
- [ ] Admin panel accessible
- [ ] Login functionality working
- [ ] All major features tested

## Post-Deployment

- [ ] Monitor error logs in PythonAnywhere dashboard
- [ ] Set up scheduled tasks if needed (cron jobs)
- [ ] Configure email settings if needed
- [ ] Set up database backups
- [ ] Document any custom configurations

## Troubleshooting

### Common Issues:

1. **500 Error**
   - Check error logs in Web tab
   - Verify WSGI configuration
   - Check that all dependencies are installed

2. **Static files not loading**
   - Verify static files mapping
   - Run `collectstatic` again
   - Check file permissions

3. **Database errors**
   - Verify migrations are run
   - Check database file permissions
   - Ensure database path is correct

4. **Import errors**
   - Verify virtual environment is activated
   - Check Python path in WSGI file
   - Ensure all dependencies are installed

## Environment Variables Reference

Create a `.env` file with:
```
SECRET_KEY=your-secret-key-here
DEBUG=False
ALLOWED_HOSTS=yourusername.pythonanywhere.com
```

Generate a secret key:
```bash
python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
```

