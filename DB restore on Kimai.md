If you have a backup of the Kimai database and you want to restore it during the fresh installation of Kimai on your Ubuntu server, follow these specific steps to ensure a smooth process. We'll integrate the database restoration process into the fresh installation steps.

### Step 1: **Update the System**
Start by updating your Ubuntu server:
```bash
sudo apt update && sudo apt upgrade -y
```

### Step 2: **Install Required Dependencies**
Install PHP, Apache, Composer, and other necessary dependencies:

#### Install PHP and Apache:
```bash
sudo apt install apache2 libapache2-mod-php php-cli php-curl php-zip php-mbstring php-xml php-intl php-gd unzip git curl -y
```

#### Install MySQL (if using MySQL for the database):
```bash
sudo apt install mysql-server php-mysql -y
```

### Step 3: **Create a Database for Kimai**
You will need to create an empty database for Kimai where you'll later restore your backup:

```bash
sudo mysql -u root -p
```

Run the following commands in the MySQL prompt:
```sql
CREATE DATABASE kimai;
CREATE USER 'kimaiuser'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON kimai.* TO 'kimaiuser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

### Step 4: **Install Composer**
Install Composer if it's not already available:
```bash
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
```

### Step 5: **Download and Install Kimai**
Clone the latest Kimai repository from GitHub into your web directory:
```bash
cd /var/www/
sudo git clone https://github.com/kevinpapst/kimai2.git kimai
cd kimai
```

Install the required PHP dependencies with Composer:
```bash
composer install --no-dev --optimize-autoloader
```

When prompted, you can provide the MySQL database credentials (you created earlier) to the installation process:

For example:
```
DATABASE_URL=mysql://kimaiuser:your_password@127.0.0.1:3306/kimai
```

### Step 6: **Restore the Database Backup**
Now, restore the backup of your old Kimai database into the newly created database.

- If your backup is a `.sql` file, run the following command:
```bash
mysql -u kimaiuser -p kimai < /path/to/your/backup.sql
```

- If your backup is compressed (e.g., `.sql.gz`), you need to unzip it first and then restore:
```bash
gunzip /path/to/your/backup.sql.gz
mysql -u kimaiuser -p kimai < /path/to/your/backup.sql
```

### Step 7: **Run Database Migrations (If Needed)**
After restoring the database, run Kimai's migration command to ensure that the database structure is up to date with the current Kimai version:
```bash
bin/console doctrine:migrations:migrate
```

This will apply any necessary changes to the database to match the new version of Kimai.

### Step 8: **Set Ownership and Permissions**
Ensure Apache can access the files by setting the correct ownership and permissions:
```bash
sudo chown -R www-data:www-data /var/www/kimai
sudo chmod -R 755 /var/www/kimai
```

### Step 9: **Configure Apache**
Set up Apache to serve Kimai by creating a virtual host configuration file:
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

Enable the site and required Apache modules:
```bash
sudo a2ensite kimai.conf
sudo a2enmod rewrite
sudo systemctl restart apache2
```

### Step 10: **Clear the Cache**
Clear the Kimai cache to avoid any issues:
```bash
bin/console cache:clear --env=prod
```

### Step 11: **Access Kimai**
Open your browser and visit `http://yourdomain.com` to access the Kimai instance. You can now log in using the credentials you had in the restored database.

---

By following these steps, you'll have a fresh installation of Kimai with your previous database backup fully restored and integrated into the new installation.
