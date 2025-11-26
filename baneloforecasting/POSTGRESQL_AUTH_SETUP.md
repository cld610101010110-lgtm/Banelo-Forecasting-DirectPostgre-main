# PostgreSQL Authentication Setup Guide

This guide explains how to set up user authentication with PostgreSQL on Railway.

## 🔄 What Changed?

**Before:** User accounts were stored in a local SQLite database (`db.sqlite3`)
**After:** All data (including user accounts) is now stored in PostgreSQL on Railway

## ✅ Benefits

1. **Unified Database:** All data in one place (PostgreSQL)
2. **Production-Ready:** Railway automatically provides PostgreSQL
3. **Scalable:** Multiple users can access the system
4. **Persistent:** Data survives server restarts

---

## 🚀 Railway Deployment Setup

### Step 1: Railway Automatically Provides PostgreSQL

When you deploy to Railway, it automatically:
- Creates a PostgreSQL database
- Sets the `DATABASE_URL` environment variable
- Your app will use this database automatically

### Step 2: Run Database Migrations

After deploying to Railway, you need to create the database tables:

#### Option A: Railway CLI

```bash
# Install Railway CLI if you haven't
npm install -g @railway/cli

# Login
railway login

# Link to your project
railway link

# Run migrations
railway run python manage.py migrate
```

#### Option B: Via Railway Dashboard

1. Go to your Railway project
2. Click on your service
3. Go to "Settings" tab
4. Scroll to "Deploy"
5. Add a "Build Command" (if not already present): `python manage.py migrate`

### Step 3: Create Your First Admin User

After migrations, create a superuser account:

#### Option A: Railway CLI

```bash
railway run python manage.py createsuperuser
```

Follow the prompts:
- **Username:** admin (or your preferred username)
- **Email:** your@email.com
- **Password:** (enter a strong password)
- **Password (again):** (confirm password)

#### Option B: Via Railway Shell

1. Go to your Railway project dashboard
2. Click on your service
3. Click "Shell" tab
4. Run the command:
```bash
python manage.py createsuperuser
```

---

## 💻 Local Development Setup

If you want to run the project locally with PostgreSQL:

### Option 1: Use Railway PostgreSQL (Recommended)

```bash
# Get your Railway DATABASE_URL
railway variables

# Copy the DATABASE_URL value, then set it locally:
export DATABASE_URL="postgresql://postgres:..."

# Run migrations
python manage.py migrate

# Create superuser
python manage.py createsuperuser

# Run server
python manage.py runserver
```

### Option 2: Use Local PostgreSQL

1. **Install PostgreSQL** (if not installed)
   - Mac: `brew install postgresql`
   - Ubuntu: `sudo apt install postgresql`
   - Windows: Download from postgresql.org

2. **Create Database**
```bash
psql postgres
CREATE DATABASE banelo_db;
\q
```

3. **Create `.env` file** in `baneloforecasting/` folder:
```env
DB_NAME=banelo_db
DB_USER=postgres
DB_PASSWORD=your_postgres_password
DB_HOST=localhost
DB_PORT=5432
```

4. **Run Migrations**
```bash
cd baneloforecasting
python manage.py migrate
```

5. **Create Superuser**
```bash
python manage.py createsuperuser
```

6. **Run Server**
```bash
python manage.py runserver
```

7. **Login**
Visit http://localhost:8000/accounts/login/

---

## 👥 Managing Users

### Creating New Users (Admin Only)

#### Method 1: Via Django Admin

1. Login as superuser
2. Visit: `https://your-app.railway.app/admin/`
3. Click "Users" → "Add User"
4. Fill in username and password
5. Click "Save"
6. Edit user details (first name, last name, email, permissions)

#### Method 2: Via Accounts Page

1. Login as staff/admin user
2. Go to "Accounts" in the sidebar
3. Click "Add User" button
4. Fill in the registration form
5. The user will be created with the specified role

#### Method 3: Via API

```bash
curl -X POST https://your-app.railway.app/dashboard/api/users/create/ \
  -H "Content-Type: application/json" \
  -d '{
    "username": "newuser",
    "email": "user@example.com",
    "password": "securepassword123",
    "first_name": "John",
    "last_name": "Doe",
    "is_staff": false
  }'
```

### User Roles

- **Superuser**: Full access to everything (Django admin, user management, all features)
- **Staff**: Access to dashboard and can manage users (but not delete)
- **Regular User**: Access to dashboard features (sales, inventory, etc.)

---

## 🔧 Database Configuration Details

The system automatically detects which database to use:

### Production (Railway)
```python
# Uses Railway's DATABASE_URL environment variable
DATABASES = {
    'default': dj_database_url.config(
        default=os.getenv('DATABASE_URL'),
        conn_max_age=600,
    )
}
```

### Local Development
```python
# Falls back to environment variables or defaults
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': os.getenv('DB_NAME', 'banelo_db'),
        'USER': os.getenv('DB_USER', 'postgres'),
        'PASSWORD': os.getenv('DB_PASSWORD', 'postgres'),
        'HOST': os.getenv('DB_HOST', 'localhost'),
        'PORT': os.getenv('DB_PORT', '5432'),
    }
}
```

---

## 🐛 Troubleshooting

### Error: "django.db.utils.OperationalError: could not connect to server"

**Cause:** Can't connect to PostgreSQL database

**Solution:**
1. Check if `DATABASE_URL` is set on Railway
2. Run migrations: `railway run python manage.py migrate`
3. Check Railway PostgreSQL service is running

### Error: "relation 'auth_user' does not exist"

**Cause:** Database tables haven't been created

**Solution:**
```bash
railway run python manage.py migrate
```

### Error: "Login failed - Invalid username or password"

**Cause:** No user accounts exist yet

**Solution:**
```bash
# Create superuser first
railway run python manage.py createsuperuser
```

### Error: "CSRF verification failed"

**Cause:** Missing CSRF cookie or wrong origin

**Solution:**
1. Check `ALLOWED_HOSTS` in settings.py includes your Railway domain
2. Clear browser cookies
3. Try in incognito mode

---

## 📊 Database Tables Created

After running migrations, these tables will be created in PostgreSQL:

### Django Auth Tables (New in PostgreSQL)
- `auth_user` - User accounts
- `auth_group` - User groups/roles
- `auth_permission` - Permissions
- `django_session` - User sessions

### Business Data Tables (Already in PostgreSQL)
- `dashboard_product` - Products/Inventory
- `dashboard_sale` - Sales records
- `dashboard_recipe` - Recipes
- `dashboard_recipeingredient` - Recipe ingredients
- `dashboard_wastelog` - Waste tracking
- `dashboard_audittrail` - Audit logs
- `dashboard_mlmodel` - ML model metadata
- `dashboard_mlprediction` - ML predictions

---

## 🔐 Security Best Practices

1. **Strong Passwords**: Use minimum 8 characters with mix of letters, numbers, symbols
2. **Limit Superusers**: Only create superuser accounts when necessary
3. **Regular Users**: Create staff or regular users for day-to-day operations
4. **Audit Trail**: All user actions are logged in the audit trail
5. **Environment Variables**: Never commit DATABASE_URL or passwords to git

---

## ✅ Verification Checklist

After setup, verify everything works:

- [ ] Railway deployment successful
- [ ] Migrations completed (`railway run python manage.py migrate`)
- [ ] Superuser created (`railway run python manage.py createsuperuser`)
- [ ] Can login at `/accounts/login/`
- [ ] Dashboard loads correctly
- [ ] Sales data visible
- [ ] Can create new users (if staff/admin)
- [ ] Logout works

---

## 📞 Need Help?

If you encounter issues:

1. Check Railway logs: `railway logs`
2. Check PostgreSQL connection: `railway run python manage.py dbshell`
3. Verify environment variables: `railway variables`
4. Re-run migrations: `railway run python manage.py migrate`

---

## 🎓 For Your Thesis

You can document this as:

> **4.2 Database Architecture**
>
> The system uses PostgreSQL as the primary database management system, hosted on Railway cloud platform. All application data including user authentication, business transactions, and ML predictions are stored in a unified PostgreSQL database.
>
> **User Authentication:** Django's built-in authentication system with PostgreSQL backend ensures secure user management. The system supports role-based access control (RBAC) with three user levels: superuser, staff, and regular users.
>
> **Database Schema:** The database consists of 12+ tables covering authentication, inventory management, sales tracking, recipe management, waste logging, and ML forecasting. All tables use PostgreSQL's ACID-compliant transactions for data integrity.
>
> **Deployment:** The application is deployed on Railway PaaS, which automatically provisions and manages the PostgreSQL database, ensuring high availability and automated backups.

---

**Last Updated:** 2025-11-26
**Compatible with:** Django 4.2+, PostgreSQL 12+, Railway
