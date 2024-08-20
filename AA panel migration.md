To migrate AA Panel from an AWS instance to a Contabo instance, you need to migrate all your websites, databases, configurations, and files. Here’s a step-by-step guide to achieve this:

### Step 1: Backup Data on AWS AA Panel

1. **SSH into AWS Instance**:
   ```bash
   ssh root@aws-instance-ip
   ```

2. **Backup all website files**:
   The website files are typically stored in `/www/wwwroot` in AA Panel. Create a backup of this directory:
   ```bash
   tar -czvf websites-backup.tar.gz /www/wwwroot
   ```

3. **Backup databases**:
   Use `mysqldump` to back up all databases:
   ```bash
   mysqldump --all-databases -u root -p > all-databases-backup.sql
   ```

4. **Backup AA Panel configuration** (including FTP, SSL, etc.):
   ```bash
   tar -czvf aa-panel-config-backup.tar.gz /www/server/panel /www/server/ftp /www/server/pure-ftpd /www/server/postfix /www/server/nginx/conf /www/server/apache/conf
   ```

5. **Download all backups to your local machine**:
   ```bash
   scp root@aws-instance-ip:/root/websites-backup.tar.gz /local/path
   scp root@aws-instance-ip:/root/all-databases-backup.sql /local/path
   scp root@aws-instance-ip:/root/aa-panel-config-backup.tar.gz /local/path
   ```

### Step 2: Set Up AA Panel on Contabo Instance

1. **SSH into Contabo Instance**:
   ```bash
   ssh root@contabo-instance-ip
   ```

2. **Update the system and install AA Panel**:
   ```bash
   sudo apt update && sudo apt upgrade -y
   wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh
   sudo bash install.sh
   ```

3. **Log in to AA Panel on Contabo**:
   - After the installation, log in to AA Panel using the URL and credentials provided by the installation script.

### Step 3: Transfer Backup Data to Contabo Instance

1. **Upload backups to Contabo**:
   ```bash
   scp /local/path/websites-backup.tar.gz root@contabo-instance-ip:/root
   scp /local/path/all-databases-backup.sql root@contabo-instance-ip:/root
   scp /local/path/aa-panel-config-backup.tar.gz root@contabo-instance-ip:/root
   ```

2. **SSH into Contabo instance again**:
   ```bash
   ssh root@contabo-instance-ip
   ```

### Step 4: Restore Website Files and Databases on Contabo

1. **Extract the website files**:
   ```bash
   tar -xzvf /root/websites-backup.tar.gz -C /www/wwwroot
   ```

2. **Restore the databases**:
   ```bash
   mysql -u root -p < /root/all-databases-backup.sql
   ```

3. **Restore AA Panel configuration**:
   Extract configuration files (such as web server configs, FTP configs, and SSL certificates):
   ```bash
   tar -xzvf /root/aa-panel-config-backup.tar.gz -C /www/server/
   ```

### Step 5: Update AA Panel Configuration on Contabo

1. **Fix file permissions**:
   ```bash
   chown -R www-data:www-data /www/wwwroot
   chmod -R 755 /www/wwwroot
   ```

2. **Check and update configurations**:
   - Ensure that the web server (Apache/Nginx) and database (MySQL/MariaDB) configurations are updated for the new Contabo environment.
   - Update your website configuration files (e.g., `wp-config.php` for WordPress or `.env` files) with new Contabo credentials.

3. **Restart services**:
   ```bash
   aaPanel restart
   systemctl restart nginx  # Or Apache, depending on your setup
   systemctl restart mysql  # Or MariaDB
   ```

### Step 6: Test the Migration

1. **Check websites**:
   Visit your domains and ensure that the websites are functioning correctly on Contabo.

2. **Verify databases**:
   Make sure that all databases are accessible and the data has been transferred successfully.

3. **Check AA Panel functionality**:
   Ensure that AA Panel services such as FTP, SSL, and cron jobs are working as expected.

This process should migrate your entire AA Panel setup, including websites, databases, and configurations, from AWS to Contabo.
