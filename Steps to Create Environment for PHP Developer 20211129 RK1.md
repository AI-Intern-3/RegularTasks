### Steps to Create Environment for PHP Developer 20211129 RK1

**Operating System:** Windows

---

#### 1. Install XAMPP (30 minutes)

a. **Download:**
   - [XAMPP 5.6.40 for Windows (64-bit)](https://sourceforge.net/projects/xampp/files/XAMPP%20Windows/5.6.40/xampp-portable-windows-x64-5.6.40-1-VC11-installer.exe/download)
  
b. **Install:**
   - Follow the installation instructions (5 minutes).

---

#### 2. Install GIT (20 minutes)

a. **Download:**
   - [Git 2.34.1 for Windows (64-bit)](https://github.com/git-for-windows/git/releases/download/v2.34.1.windows.1/Git-2.34.1-64-bit.exe)

---

#### 3. Create `localhost.smartcookie.in` (5 minutes)

a. **Locate hosts file:**
   - Path: `C:\Windows\System32\drivers\etc\hosts`

b. **Edit hosts file:**
   - Open in a text editor (e.g., Sublime Text).
   - Add the following line at the end of the file:
     ```
     127.0.0.1       localhost.smartcookie.in
     ```

c. **Locate `httpd-vhosts.conf`:**
   - Path: `C:\xampp\apache\conf\extra\httpd-vhosts.conf`

d. **Edit `httpd-vhosts.conf`:**
   - Open in Sublime Text.
   - Locate the `<VirtualHost *:80>` section and add the following:
     ```apache
     <VirtualHost *:80>
       DocumentRoot "C:\xampp\htdocs\localhost\smartcookie\"
       ServerName localhost.smartcookie.in
       ServerAlias localhost.smartcookie.in
     </VirtualHost>
     ```

---

#### 4. Locate your XAMPP Folder

- Path: `C:\XAMPP\htdocs\`

---

#### 5. Create `localhost` Folder

- Create a new folder named `localhost` in the XAMPP `htdocs` directory.

---

#### 6. Clone Repositories Using Git

a. **Right-click in the `localhost` folder:**
   - Select "Git Bash Here".

b. **Use the following Git Clone commands:**
   ```bash
   git clone https://internsbpsi@bitbucket.org/BPSI-Master/smartcookie.git
   git clone https://internsbpsi@bitbucket.org/BPSI-Master/dev.cjnnow.com.git
   git clone https://internsbpsi@bitbucket.org/BPSI-Master/startupworld_aws.git
   ```

   **Password:** `jnPxpGvtCh2B38PjgyVW`

---

#### 7. Place Application Folder in Smartcookie Folder

- Copy the application folder into the `C:\xampp\htdocs\localhost\smartcookie\` directory.

---

#### 8. Add Connection Files (5 minutes)

a. **Paste `conn.php` in the following folders:**
   - `C:\xampp\htdocs\localhost\smartcookie\core\`
   - `C:\xampp\htdocs\localhost\smartcookie\core\webservice\`
   - All Version Folders (e.g., `Version2`, `Version4`, etc.)

b. **Paste `connsqli.php` in the `core` folder:**
   - Path: `C:\xampp\htdocs\localhost\smartcookie\core\`

---

#### 9. Modify `php.ini` (5 minutes)

a. **Locate `php.ini`:**
   - Path: `C:\xampp\php\php.ini`

b. **Edit `php.ini`:**
   - Open in Sublime Text.
   - Search and replace the following lines:
     ```
     post_max_size=2048M
     upload_max_filesize=2048M
     memory_limit=2048M
     max_execution_time=-1
     max_input_time=-1
     ```

---

#### 10. Start XAMPP Control Panel

- Open the XAMPP Control Panel.

---

#### 11. Start Apache and MySQL Services

- Click the "Start" button for both Apache and MySQL.

---

**Happy Coding!**
