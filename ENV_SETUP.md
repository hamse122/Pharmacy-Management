# Environment Variables Setup

This project uses environment variables for configuration. You need to create a `.env` file in the `pms` directory.

## Creating the .env File

1. Create a file named `.env` in the `pms` directory (same level as `manage.py`)

2. Add the following content:

```env
# Django Settings
SECRET_KEY=your-secret-key-here
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1
```

## For Local Development

```env
SECRET_KEY=your-secret-key-here
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1
```

## For Production (PythonAnywhere)

```env
SECRET_KEY=your-production-secret-key-here
DEBUG=False
ALLOWED_HOSTS=yourusername.pythonanywhere.com
```

## Generating a Secret Key

You can generate a Django secret key using:

```bash
python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
```

## Important Notes

- **Never commit the `.env` file to version control** - it's already in `.gitignore`
- Use different secret keys for development and production
- Always set `DEBUG=False` in production
- Include your PythonAnywhere domain in `ALLOWED_HOSTS` for production

## Database Configuration (Optional)

If you're using MySQL on PythonAnywhere, you can add these to your `.env`:

```env
DB_NAME=your_db_name
DB_USER=your_db_user
DB_PASSWORD=your_db_password
DB_HOST=your_db_host.mysql.pythonanywhere-services.com
DB_PORT=3306
```

Then update `settings.py` to use these variables if needed.

