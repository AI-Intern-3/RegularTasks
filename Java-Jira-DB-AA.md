To install Jira on Ubuntu with a managed PostgreSQL database provided by Contabo, follow these steps:

### Step 1: Prepare the Ubuntu Server

1. **Access Your Contabo Server:**
   - Use SSH to connect to your Contabo server.
   ```bash
   ssh your_user@your_contabo_server_ip
   ```

2. **Update the System:**
   ```bash
   sudo apt update
   sudo apt upgrade -y
   ```

3. **Install Java Development Kit (JDK):**
   Jira requires JDK. Install OpenJDK by running:
   ```bash
   sudo apt install openjdk-11-jdk -y
   ```

4. **Verify Java Installation:**
   ```bash
   java -version
   ```

### Step 2: Install Jira

1. **Create a Dedicated User for Jira:**
   ```bash
   sudo adduser --system --home /opt/jira --shell /bin/bash --group jira
   ```

2. **Download Jira:**
   Visit the [Atlassian Jira download page](https://www.atlassian.com/software/jira/download) to get the download link for the latest Jira version. Then, download Jira using `wget`.
   ```bash
   wget https://product-downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-X.Y.Z.tar.gz
   ```

3. **Extract the Downloaded Archive:**
   ```bash
   sudo tar -xvzf atlassian-jira-software-X.Y.Z.tar.gz -C /opt/
   ```

4. **Create a Symbolic Link:**
   ```bash
   sudo ln -s /opt/atlassian-jira-software-X.Y.Z-standalone /opt/jira
   ```

5. **Set Up Jira Home Directory:**
   ```bash
   sudo mkdir /var/atlassian/application-data/jira
   sudo chown -R jira:jira /var/atlassian/application-data/jira
   ```

6. **Configure Jira Home Directory:**
   Edit the `jira-application.properties` file.
   ```bash
   sudo nano /opt/jira/atlassian-jira/WEB-INF/classes/jira-application.properties
   ```
   Add the following line:
   ```properties
   jira.home = /var/atlassian/application-data/jira
   ```

7. **Set Jira Permissions:**
   ```bash
   sudo chown -R jira:jira /opt/jira
   ```

### Step 3: Configure PostgreSQL Database on Contabo

1. **Set Up Managed PostgreSQL Database on Contabo:**
   - Log in to your Contabo dashboard and set up a managed PostgreSQL database instance.
   - Note down the database connection details such as the host, port, database name, username, and password.

### Step 4: Configure Jira to Use Managed PostgreSQL Database

1. **Configure Database Connection:**
   Edit the `dbconfig.xml` file in the Jira home directory.
   ```bash
   sudo nano /var/atlassian/application-data/jira/dbconfig.xml
   ```
   Add the following configuration (adjust as needed):
   ```xml
   <jira-database-config>
       <name>defaultDS</name>
       <database-type>postgres72</database-type>
       <schema-name>public</schema-name>
       <jdbc-datasource>
           <url>jdbc:postgresql://<contabo_db_host>:<contabo_db_port>/<contabo_db_name></url>
           <driver-class>org.postgresql.Driver</driver-class>
           <username><contabo_db_username></username>
           <password><contabo_db_password></password>
           <pool-min-size>20</pool-min-size>
           <pool-max-size>20</pool-max-size>
           <pool-max-wait>30000</pool-max-wait>
           <validation-query>select 1</validation-query>
           <validation-query-timeout>3</validation-query-timeout>
           <min-evictable-idle-time-millis>60000</min-evictable-idle-time-millis>
           <time-between-eviction-runs-millis>300000</time-between-eviction-runs-millis>
       </jdbc-datasource>
   </jira-database-config>
   ```

### Step 5: Start Jira

1. **Start Jira:**
   ```bash
   sudo -u jira /opt/jira/bin/start-jira.sh
   ```

2. **Access Jira:**
   Open your web browser and go to `http://your_server_ip:8080` to continue the Jira setup.

### Step 6: Complete Jira Setup

1. **Web-Based Configuration:**
   Follow the web-based configuration steps to complete setting up Jira. During this process, you'll need to provide the database connection details you configured earlier.

### Step 1: Install AA Panel on Contabo

1. **Access Your Contabo Server:**
   - Use SSH to connect to your Contabo server.
   ```bash
   ssh your_user@your_contabo_server_ip
   ```

2. **Update the System:**
   ```bash
   sudo apt update
   sudo apt upgrade -y
   ```

3. **Install AA Panel:**
   - AA Panel provides an easy-to-use script to install the panel.
   ```bash
   wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh
   sudo bash install.sh
   ```

4. **Note Down AA Panel Details:**
   - After the installation, the script will provide the URL, username, and password to access the AA Panel.

### Step 2: Configure the Database in AA Panel

1. **Log in to AA Panel:**
   - Open a web browser and navigate to the AA Panel URL provided during the installation.
   - Log in using the credentials provided.

2. **Install PostgreSQL Database:**
   - Navigate to the "App Store" in AA Panel.
   - Search for "PostgreSQL" and click "Install."
   - Follow the prompts to complete the installation.

3. **Create a Database and User for Jira:**
   - Go to the "Database" section in AA Panel.
   - Click on "Add Database" and provide the necessary details:
     - Database Name: `jiradb`
     - Username: `jiradbuser`
     - Password: `yourpassword`
   - Click "Submit" to create the database and user.

To configure an already created managed PostgreSQL database named `jiraphp` in AA Panel on Contabo, follow these steps:

### Step 2: Configure the Existing Managed Database in AA Panel of Contabo

1. **Access AA Panel:**
   - Open your web browser and navigate to the URL provided during the AA Panel installation.
   - Log in using the credentials provided.

2. **Navigate to Database Management:**
   - Once logged in, go to the **"Databases"** or **"Database Management"** section in the AA Panel dashboard.

3. **Add the Managed Database to AA Panel:**
   - If the database `jiraphp` is not yet visible in the AA Panel, you need to configure a new connection to this managed database.
   - Click on **“Add Database”** or **“New Connection”** (the exact wording may vary).

4. **Enter Database Connection Details:**
   - **Database Type:** Select **PostgreSQL**.
   - **Database Host:** Enter the hostname or IP address provided by Contabo for the PostgreSQL managed database. This information should be available in your Contabo dashboard or from the database configuration details.
   - **Database Port:** Enter `5432` (the default port for PostgreSQL) or the specific port number if different.
   - **Database Name:** Enter `jiraphp`.
   - **Username:** Enter the database username provided by Contabo.
   - **Password:** Enter the password for the database user.

5. **Test the Connection:**
   - Click on **“Test Connection”** to verify that AA Panel can successfully connect to the PostgreSQL database.
   - Ensure that there are no errors during the connection test. If there are issues, double-check the database connection details, network settings, and firewall rules.

6. **Save the Configuration:**
   - Once the connection test is successful, click **“Save”** or **“Apply”** to finalize the database connection setup.

7. **Configure Jira to Use the Managed Database:**
   - Now, configure Jira to connect to this managed PostgreSQL database.
   - **Edit the `dbconfig.xml` File:**
     - Locate the `dbconfig.xml` file in your Jira home directory (`/var/atlassian/application-data/jira/dbconfig.xml`).
     - Edit the file with the following configuration:
       ```xml
       <jira-database-config>
           <name>defaultDS</name>
           <database-type>postgres72</database-type>
           <schema-name>public</schema-name>
           <jdbc-datasource>
               <url>jdbc:postgresql://<database_host>:<database_port>/jiraphp</url>
               <driver-class>org.postgresql.Driver</driver-class>
               <username><database_username></username>
               <password><database_password></password>
               <pool-min-size>20</pool-min-size>
               <pool-max-size>20</pool-max-size>
               <pool-max-wait>30000</pool-max-wait>
               <validation-query>select 1</validation-query>
               <validation-query-timeout>3</validation-query-timeout>
               <min-evictable-idle-time-millis>60000</min-evictable-idle-time-millis>
               <time-between-eviction-runs-millis>300000</time-between-eviction-runs-millis>
           </jdbc-datasource>
       </jira-database-config>
       ```
   - Replace `<database_host>`, `<database_port>`, `<database_username>`, and `<database_password>` with the actual values provided by Contabo.

8. **Restart Jira:**
   - After updating the `dbconfig.xml` file, restart the Jira application to apply the changes:
     ```bash
     sudo -u jira /opt/jira/bin/start-jira.sh
     ```

### Additional Tips

- **Firewall Rules:** Ensure that your Contabo server’s firewall allows connections to the PostgreSQL port (5432).
- **Permissions:** Verify that the database user has the necessary permissions to read from and write to the `jiraphp` database.
- **Backup:** Ensure you have a backup of your Jira data and database configuration before making changes.
