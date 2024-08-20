To migrate all your data from an AWS server running AA Panel to another Contabo server also running AA Panel, follow these steps:

### Step 1: Backup Data on AWS AA Panel

1. **SSH into AWS Server**:
   ```bash
   ssh root@aws-server-ip
   ```

2. **Backup all website data**:
   AA Panel stores website files in `/www/wwwroot`, so create a compressed backup of the directory:
   ```bash
   tar -czvf websites-backup.tar.gz /www/wwwroot
   ```

3. **Backup databases**:
   Backup all databases managed by MySQL or MariaDB:
   ```bash
   mysqldump --all-databases -u root -p > all-databases-backup.sql
   ```

4. **Backup email and FTP data (optional)**:
   If you have FTP accounts or email setup, back those up too:
   ```bash
   tar -czvf ftp-backup.tar.gz /www/server/pure-ftpd
   tar -czvf mail-backup.tar.gz /www/server/postfix
   ```

5. **Download backups to local machine**:
   ```bash
   scp root@aws-server-ip:/root/websites-backup.tar.gz /local/path
   scp root@aws-server-ip:/root/all-databases-backup.sql /local/path
   scp root@aws-server-ip:/root/ftp-backup.tar.gz /local/path
   scp root@aws-server-ip:/root/mail-backup.tar.gz /local/path
   ```

### Step 2: Transfer Data to Contabo AA Panel

1. **Upload backups to Contabo**:
   ```bash
   scp /local/path/websites-backup.tar.gz root@contabo-server-ip:/root
   scp /local/path/all-databases-backup.sql root@contabo-server-ip:/root
   scp /local/path/ftp-backup.tar.gz root@contabo-server-ip:/root
   scp /local/path/mail-backup.tar.gz root@contabo-server-ip:/root
   ```

2. **SSH into Contabo Server**:
   ```bash
   ssh root@contabo-server-ip
   ```

### Step 3: Restore Data on Contabo AA Panel

1. **Extract website files**:
   ```bash
   tar -xzvf /root/websites-backup.tar.gz -C /www/wwwroot
   ```

2. **Restore databases**:
   ```bash
   mysql -u root -p < /root/all-databases-backup.sql
   ```

3. **Restore FTP and mail data (if needed)**:
   ```bash
   tar -xzvf /root/ftp-backup.tar.gz -C /www/server/pure-ftpd
   tar -xzvf /root/mail-backup.tar.gz -C /www/server/postfix
   ```

### Step 4: Update Configuration on Contabo

1. **Update website configurations**:
   - Update any site-specific configurations (e.g., database credentials) to match the new Contabo environment.

2. **Restart services**:
   ```bash
   aaPanel restart    # Restart the AA Panel
   systemctl restart nginx  # Or Apache, depending on the web server you're using
   systemctl restart mysql  # Restart MySQL
   ```

### Step 5: Verify the Migration

1. **Check website functionality**: 
   Visit your domains and check if everything is working as expected.

2. **Check database and email**:
   Ensure all databases, email, and FTP services are functioning correctly.

This process clones all of your data from AWS to Contabo, keeping the AA Panel configurations consistent.
