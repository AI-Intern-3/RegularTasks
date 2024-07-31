Here's the step-by-step guide for installing Jira on a Contabo server:

---

### **Step-by-Step Guide to Install Jira Application**

#### **1. Connect to Your Server**
   ```bash
   ssh root@your_contabo_server_ip
   ```

#### **Prerequisites**
1. **JDK or JRE**
2. **Jira tar file**
3. **Linux/Ubuntu Environment**

#### **2. Create a Dedicated User for Jira**
   It's recommended to run Jira as a dedicated user:
   ```bash
   sudo /usr/sbin/useradd --create-home --comment "Account for running Jira Software" --shell /bin/bash jira
   ```

#### **3. Install and Configure Java in Linux/Ubuntu**
   Jira provides JRE support, but you can also install Java manually:

   **Install Java (if not already installed):**
   ```bash
   sudo apt update
   sudo apt install openjdk-11-jdk -y
   ```

   **Find the Java Installation Directory:**
   ```bash
   readlink -f $(which java)
   ```
   Example output:
   ```bash
   /usr/lib/jvm/java-11-openjdk-amd64/bin/java
   ```

   **Set JAVA_HOME Environment Variable:**
   ```bash
   export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
   export PATH=$JAVA_HOME/bin:$PATH
   ```
   **Persist the JAVA_HOME Setting:**
   ```bash
   nano ~/.bashrc
   ```
   Add the following lines:
   ```bash
   export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
   export PATH=$JAVA_HOME/bin:$PATH
   ```
   **Reload the Profile:**
   ```bash
   source ~/.bashrc
   ```

#### **4. Download and Install Jira**
   **Download Jira Software:**
   ```bash
   wget https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-software-9.12.11.tar.gz
   ```
   (Change the version as per your requirement)

   **Create the Installation Directory:**
   ```bash
   sudo mkdir /opt/jira
   sudo tar -xzvf atlassian-jira-software-9.12.11.tar.gz -C /opt/jira --strip-components=1
   ```
   `--strip-components=1`: Skips the top-level directory in the tar file.

   **Set Permissions for the Dedicated Jira User:**
   ```bash
   sudo chown -R jira:jira /opt/jira
   sudo chmod -R u=rwx,go-rwx /opt/jira
   ```

#### **5. Create the Home Directory**
   **Create the Home Directory:**
   ```bash
   sudo mkdir /var/jirasoftware-home
   sudo chown -R jira:jira /var/jirasoftware-home
   sudo chmod -R u=rwx,go-rwx /var/jirasoftware-home
   ```

   **Configure Jira to Use the Home Directory:**
   - **Method 1: Set Environment Variable**
     ```bash
     export JIRA_HOME=/var/jirasoftware-home
     ```
   - **Method 2: Edit the `jira-application.properties` File**
     ```bash
     sudo nano /opt/jira/atlassian-jira/WEB-INF/classes/jira-application.properties
     ```
     Add the following line:
     ```bash
     jira.home=/var/jirasoftware-home
     ```

#### **6. Check and Configure Ports (Optional)**
   **Edit the `server.xml` File to Change Default Ports:**
   ```bash
   sudo nano /opt/jira/conf/server.xml
   ```
   Change the Server port (8005) and the Connector port (8080) to your preferred ports:
   ```xml
   <Server port="5005" shutdown="SHUTDOWN">
   ...
   <Service name="Catalina">
      <Connector port="5050"
         maxThreads="150"
         minSpareThreads="25"
         connectionTimeout="20000"
         enableLookups="false"
         maxHttpHeaderSize="8192"
         protocol="HTTP/1.1"
         useBodyEncodingForURI="true"
         redirectPort="8443"
         acceptCount="100"
         disableUploadTimeout="true"/>
   ```

#### **7. Start Jira**
   **Run the Start Script:**
   ```bash
   sudo -u jira /opt/jira/bin/start-jira.sh
   ```

   **If You're Using Ubuntu, Run:**
   ```bash
   sudo su - jira
   ./start-jira.sh
   ```

   **Access Jira in Your Browser:**
   Visit `http://localhost:8080/` or the port you configured.

   **If Errors Occur:**
   Check if the port is listening and open on your server.

---

This guide provides all the necessary steps to install Jira on your Contabo server, from setting up the environment to running the application.
