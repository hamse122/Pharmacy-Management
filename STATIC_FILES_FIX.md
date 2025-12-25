# Fix for Images Not Loading on PythonAnywhere

## Problem
Images and static files are not loading on PythonAnywhere deployment.

## Root Causes

1. **Media files only served when DEBUG=True** - In production, DEBUG=False, so Django doesn't serve media files
2. **Static files mapping incorrect** - Wrong directory paths in PythonAnywhere Web tab
3. **collectstatic not run** - Static files not collected to staticfiles directory
4. **Project directory name mismatch** - Cloned as `Pharmacy-Management` not `pms`

## Solutions

### Solution 1: Fix Static Files Mapping in PythonAnywhere

1. Go to **Web** tab in PythonAnywhere
2. Scroll to **"Static files"** section
3. **Remove** any existing static file mappings
4. Add these mappings (check your actual project directory name):

   **If your project is in `/home/xamse/Pharmacy-Management/`:**
   - URL: `/static/` → Directory: `/home/xamse/Pharmacy-Management/staticfiles`
   - URL: `/media/` → Directory: `/home/xamse/Pharmacy-Management/media`

   **If your project is in `/home/xamse/pms/`:**
   - URL: `/static/` → Directory: `/home/xamse/pms/staticfiles`
   - URL: `/media/` → Directory: `/home/xamse/pms/media`

5. Click **Save**
6. Click **Reload** button

### Solution 2: Run collectstatic Again

In your Bash console:

```bash
cd ~/Pharmacy-Management  # or cd ~/pms (check your actual directory)
source venv/bin/activate
python manage.py collectstatic --noinput
```

### Solution 3: Verify Directory Structure

Check if directories exist:

```bash
cd ~/Pharmacy-Management  # or cd ~/pms
ls -la
```

You should see:
- `staticfiles/` directory (created by collectstatic)
- `media/` directory (for uploaded files)
- `static/` directory (source static files)

### Solution 4: Check File Permissions

Make sure directories are readable:

```bash
chmod -R 755 staticfiles/
chmod -R 755 media/
```

### Solution 5: Verify Settings

Check your `settings.py` has correct paths:

```python
STATIC_URL = 'static/'
STATICFILES_DIRS = [os.path.join(BASE_DIR, 'static')]
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')

MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
```

## Quick Checklist

- [ ] Static files mapping configured in Web tab
- [ ] Media files mapping configured in Web tab
- [ ] Ran `collectstatic` command
- [ ] Directory paths match actual project location
- [ ] Web app reloaded after changes
- [ ] File permissions are correct (755)

## Testing

After fixing, test by accessing:
- Static files: `https://xamse.pythonanywhere.com/static/css/yourfile.css`
- Media files: `https://xamse.pythonanywhere.com/media/yourimage.jpg`

If you see 404 errors, check:
1. The file actually exists in that directory
2. The URL mapping is correct
3. The directory path is correct

## Common Mistakes

1. **Wrong directory name** - Using `pms` instead of `Pharmacy-Management` (or vice versa)
2. **Missing trailing slash** - URL should be `/static/` not `/static`
3. **Case sensitivity** - Linux is case-sensitive, check exact directory names
4. **Not reloading** - Always reload web app after changing static files mapping

