### Step-by-Step Guide to Install Jira Application

#### 1. Download Jira
First, download the appropriate Jira tar.gz file for your operating system:
- [Jira Core](https://www.atlassian.com/software/jira/core/download)
- [Jira Software](https://www.atlassian.com/software/jira/download)
- [Jira Service Management](https://www.atlassian.com/software/jira/service-desk/download)

#### 2. Create the Installation Directory
1. Open your terminal.
2. Create your installation directory. For example:
   ```bash
   sudo mkdir /opt/jira
   ```
3. Extract the Jira tar.gz file to your installation directory:
   ```bash
   sudo tar -xzvf atlassian-jira-x.x.x.tar.gz -C /opt/jira --strip-components=1
   ```
4. Give your dedicated Jira user read, write, and execute permissions to the installation directory:
   ```bash
   sudo chown -R jira:jira /opt/jira
   sudo chmod -R u=rwx,go-rwx /opt/jira
   ```

#### 3. Create the Home Directory
1. Create your home directory:
   ```bash
   sudo mkdir /var/jirasoftware-home
   ```
2. Give your dedicated Jira user read, write, and execute permissions to the home directory:
   ```bash
   sudo chown -R jira:jira /var/jirasoftware-home
   sudo chmod -R u=rwx,go-rwx /var/jirasoftware-home
   ```
3. Tell Jira where to find your home directory by setting an environment variable:
   ```bash
   export JIRA_HOME=/var/jirasoftware-home
   ```
   Alternatively, edit the `jira-application.properties` file:
   ```bash
   sudo nano /opt/jira/atlassian-jira/WEB-INF/classes/jira-application.properties
   ```
   Add the following line:
   ```bash
   jira.home=/var/jirasoftware-home
   ```

#### 4. Check the Ports
1. Edit the `server.xml` file to change the default ports:
   ```bash
   sudo nano /opt/jira/conf/server.xml
   ```
2. Change the Server port (8005) and the Connector port (8080) to free ports on your server. For example:
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

#### 5. Start Jira
1. Run the start script to start the setup process:
   ```bash
   sudo -u jira /opt/jira/bin/start-jira.sh
   ```
2. If you're using Ubuntu, use:
   ```bash
   sudo su - jira
   ./start-jira.sh
   ```
3. Access Jira in your browser at [http://localhost:8080/](http://localhost:8080/) (or the port you configured).

By following these steps, you should be able to successfully install and start Jira on your server.
