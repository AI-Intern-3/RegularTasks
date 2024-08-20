### 📋 **Short Summary: VPS Issue Reporting Steps for Ubuntu**

---

1. **🔧 Install MTR**  
   - Update the package list and install MTR:
   ```bash
   sudo apt-get update
   sudo apt-get install mtr
   ```

---

2. **📊 Generate MTR Report**  
   - Run the MTR report with 100 tests:
   ```bash
   sudo mtr -r -c 100 your_server_ip
   ```

---

3. **📸 Take Screenshot of the Issue**  
   - Capture a screenshot of the problem on your VPS.

---

4. **🔐 Prepare Login Credentials**  
   - Include:
     - **Server IP address**
     - **SSH username** (e.g., `root`)
     - **Password** or **private key**

---

5. **✉️ Send Information to Support**  
   - Email the support team:
     - MTR report
     - Screenshot
     - Login credentials

--- 

Follow these steps to report the VPS issue efficiently!
