To properly address the issue you're experiencing with your VPS, here are **detailed steps** on how to create an MTR report and provide the necessary information to the support team:

### **Step 1: Install MTR on Your Server**

#### For Linux (Ubuntu/Debian):
1. SSH into your VPS:
   ```bash
   ssh user@your_server_ip
   ```
2. Install the `mtr` tool:
   ```bash
   sudo apt-get update
   sudo apt-get install mtr
   ```

#### For CentOS/RHEL:
1. SSH into your VPS:
   ```bash
   ssh user@your_server_ip
   ```
2. Install `mtr` using the following command:
   ```bash
   sudo yum install mtr
   ```

#### For Windows:
1. Download **WinMTR** from [WinMTR download page](https://sourceforge.net/projects/winmtr/).
2. Install and run **WinMTR**.

---

### **Step 2: Generate MTR Report**

#### For Linux:
1. Run the MTR report by executing the following command:
   ```bash
   sudo mtr -r -c 100 your_server_ip
   ```
   - Replace `your_server_ip` with the **destination server's IP** (the server you want to test the connection to).
   - The `-r` flag generates a report, and `-c 100` runs 100 tests for more accurate results.

2. The report will show a detailed analysis of the network hops between your machine and the destination.

#### For Windows (WinMTR):
1. Open **WinMTR**.
2. Enter the IP address of the destination server in the "Host" field.
3. Click **Start**.
4. After running for a few minutes, click **Stop** and then click **Copy Text to Clipboard** to save the report.

---

### **Step 3: Take a Screenshot of the Issue**
1. Recreate the issue you’re facing on your VPS.
2. Take a **screenshot** showing the issue clearly.
   - For Windows: Press `Windows + Shift + S` and select the area to capture.
   - For macOS: Press `Command + Shift + 4`.
   - For Linux: Use a screenshot tool or press `PrtSc` on your keyboard.

---

### **Step 4: Prepare Login Credentials**
- Make sure you include the **SSH credentials** to access your VPS.
  - **IP address** of the server.
  - **SSH user** (e.g., `root` or another user).
  - **SSH password** or private key for login.

---

### **Step 5: Send the Information**
1. Send the following information to the support team via their provided support email or ticketing system:
   - **MTR report**.
   - **Login credentials** (IP address, username, and password/private key).
   - **Screenshot** of the issue.
2. Include a detailed description of the issue you're facing.

---

### **Additional Documentation**
- Check their documentation on troubleshooting VPS issues for more insights. This might be linked in the original support message, or you can check the support section of your VPS provider's website.

---

### **Step 6: Follow-Up**
- Wait for the support team to analyze the information and provide feedback.
- If necessary, stay in touch with them for further clarifications or actions.

By following these steps, you'll provide the necessary information for the support team to diagnose and resolve your issue efficiently.
