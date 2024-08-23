To perform a fresh installation of Kimai with a database backup integration on an Ubuntu server running your PHP application, follow these comprehensive steps:

---

### Step 1: **Update Your System**
Ensure your Ubuntu server is up to date:
```bash
sudo apt update && sudo apt upgrade -y
```

### Step 2: **Install Required Dependencies**
You’ll need to install PHP, Composer, MySQL (or MariaDB), and other required packages:

#### Install PHP and Apache:
```bash
sudo apt install apache2 libapache2-mod-php php-cli php-curl php-zip php-mbstring php-xml php-intl php-gd unzip git curl -y
```

#### Install MySQL (if using MySQL for the database):
```bash
sudo apt install mysql-server php-mysql -y
```

### Step 3: **Create the Kimai Database and User**
Login to MySQL and create a database and user for Kimai:
```bash
sudo mysql -u root -p
```

Inside the MySQL prompt, run the following commands to create the Kimai database and user:
```sql
CREATE DATABASE kimai;
CREATE USER 'kimaiuser'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON kimai.* TO 'kimaiuser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

### Step 4: **Install Composer**
If Composer is not already installed, install it:
```bash
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
```

### Step 5: **Download and Install Kimai**
Clone the Kimai repository into your web directory:
```bash
cd /var/www/
sudo git clone https://github.com/kevinpapst/kimai2.git kimai
cd kimai
```

Install Kimai dependencies via Composer:
```bash
composer install --no-dev --optimize-autoloader
```

When prompted, provide the required database details:

For MySQL, your `DATABASE_URL` should look like this:
```
DATABASE_URL=mysql://kimaiuser:your_password@127.0.0.1:3306/kimai
```

### Step 6: **Set Ownership and Permissions**
Ensure that the correct permissions are set for Apache to access the Kimai files:
```bash
sudo chown -R www-data:www-data /var/www/kimai
sudo chmod -R 755 /var/www/kimai
```

### Step 7: **Apache Configuration**
Create an Apache configuration file for Kimai:
```bash
sudo nano /etc/apache2/sites-available/kimai.conf
```

Add the following configuration:
```bash
<VirtualHost *:80>
    ServerAdmin admin@example.com
    DocumentRoot /var/www/kimai/public
    ServerName yourdomain.com
    <Directory /var/www/kimai/public>
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog ${APACHE_LOG_DIR}/kimai_error.log
    CustomLog ${APACHE_LOG_DIR}/kimai_access.log combined
</VirtualHost>
```

Enable the site and necessary Apache modules:
```bash
sudo a2ensite kimai.conf
sudo a2enmod rewrite
sudo systemctl restart apache2
```

### Step 8: **Restore the Database Backup**
If you have an existing database backup that needs to be restored, follow these steps.

Transfer the backup file to your server (if not already there), then restore it:
```bash
mysql -u kimaiuser -p kimai < /path/to/your/backup.sql
```

### Step 9: **Run Database Migrations**
After restoring the database, run any required database migrations to ensure compatibility with the latest version of Kimai:
```bash
bin/console doctrine:migrations:migrate
```

### Step 10: **Clear the Cache**
Clear the cache to ensure smooth operation:
```bash
bin/console cache:clear --env=prod
```

### Step 11: **Set Up Kimai Configuration**
Ensure that your Kimai configuration file `.env` matches the correct database URL:
```bash
nano .env
```

Example for MySQL:
```
DATABASE_URL=mysql://kimaiuser:your_password@127.0.0.1:3306/kimai
```

### Step 12: **Testing and Accessing Kimai**
1. Access the Kimai instance by opening a browser and navigating to `http://yourdomain.com`.
2. Log in using the credentials you set during the installation.

---

### Optional: **Enable HTTPS (SSL)**
If you want to secure the installation with HTTPS, follow these additional steps:

1. **Install Certbot for SSL:**
   ```bash
   sudo apt install certbot python3-certbot-apache -y
   ```

2. **Obtain an SSL Certificate:**
   ```bash
   sudo certbot --apache -d yourdomain.com
   ```

3. **Restart Apache to apply changes:**
   ```bash
   sudo systemctl restart apache2
   ```

---

Following these steps, you should have a fully functional, freshly installed version of Kimai with your database backup integrated into your PHP application on the Ubuntu webserver.
