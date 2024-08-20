Here are the steps and terminal commands to migrate your website code and database from GoDaddy to Contabo:

### Step 1: Backup Website Code on GoDaddy

1. **Access GoDaddy via SSH**:
   ```bash
   ssh username@godaddy-server-ip
   ```

2. **Navigate to the website directory**:
   ```bash
   cd /path/to/your/website
   ```

3. **Compress the website files**:
   ```bash
   tar -czvf website-backup.tar.gz .
   ```

4. **Download the backup** to your local machine:
   ```bash
   scp username@godaddy-server-ip:/path/to/website-backup.tar.gz /local/path
   ```

### Step 2: Backup Database on GoDaddy

1. **Backup the database**:
   ```bash
   mysqldump -u db_user -p db_name > website_db_backup.sql
   ```

2. **Download the database backup** to your local machine:
   ```bash
   scp username@godaddy-server-ip:/path/to/website_db_backup.sql /local/path
   ```

### Step 3: Transfer Code and Database to Contabo

1. **Upload website files to Contabo**:
   ```bash
   scp /local/path/website-backup.tar.gz username@contabo-server-ip:/path/to/destination
   ```

2. **Upload database backup to Contabo**:
   ```bash
   scp /local/path/website_db_backup.sql username@contabo-server-ip:/path/to/destination
   ```

### Step 4: Restore Website Code on Contabo

1. **SSH into Contabo**:
   ```bash
   ssh username@contabo-server-ip
   ```

2. **Navigate to the web root**:
   ```bash
   cd /path/to/website/directory
   ```

3. **Extract the website files**:
   ```bash
   tar -xzvf /path/to/website-backup.tar.gz
   ```

4. **Set the correct permissions**:
   ```bash
   chown -R www-data:www-data /path/to/website/directory
   chmod -R 755 /path/to/website/directory
   ```

### Step 5: Restore Database on Contabo

1. **Log in to MySQL**:
   ```bash
   mysql -u db_user -p
   ```

2. **Create a new database**:
   ```sql
   CREATE DATABASE db_name;
   ```

3. **Import the backup**:
   ```bash
   mysql -u db_user -p db_name < /path/to/website_db_backup.sql
   ```

### Step 6: Update Configurations

1. **Update your website’s configuration** (e.g., `wp-config.php` for WordPress or `.env` for Laravel) with the new Contabo database credentials and server details.

2. **Restart the webserver**:
   ```bash
   sudo systemctl restart apache2  # If using Apache
   sudo systemctl restart nginx    # If using Nginx
   ```

Once all steps are completed, your website should be successfully migrated from GoDaddy to Contabo.
