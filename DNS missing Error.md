Certainly! Here are detailed steps to resolve the DNS issue, using both command-line tools and addressing potential fixes on your web hosting server.

### Steps to Resolve DNS Issue:

1. **Check for Typos:**
   - Ensure the URL `time.bpsi.us` is correctly typed.

2. **Flush DNS Cache:**
   - **Windows:**
     - Open Command Prompt as an administrator.
     - Run: `ipconfig /flushdns`
   - **macOS:**
     - Open Terminal.
     - Run: `sudo killall -HUP mDNSResponder`
   - **Linux:**
     - Open Terminal.
     - Run: `sudo systemd-resolve --flush-caches`

3. **Check DNS Resolution:**

   - **Using nslookup:**
     - Open a command prompt or terminal.
     - Run: `nslookup time.bpsi.us`
     - To use a specific DNS server: `nslookup time.bpsi.us 8.8.8.8` (replace `8.8.8.8` with the IP address of your preferred DNS server).

   - **Using dig:**
     - Open a terminal.
     - Run: `dig time.bpsi.us`
     - To use a specific DNS server: `dig @8.8.8.8 time.bpsi.us` (replace `8.8.8.8` with the IP address of your preferred DNS server).

   **Example Output:**
   ```sh
   smit@DESKTOP-0N62A4P:~$ nslookup time.bpsi.us
   Server:         10.255.255.254
   Address:        10.255.255.254#53

   Non-authoritative answer:
   Name:   time.bpsi.us
   Address: 3.109.238.229
   Name:   time.bpsi.us
   Address: 64:ff9b::36d:eee5
   ```

4. **Check DNS Server:**
   - Ensure that the DNS server you are using is functioning correctly and can resolve the domain name.

### If DNS Records Are Missing:

If the DNS lookup does not return the correct IP address, there may be an issue with the DNS records. Here’s how to fix it using your web hosting server’s control panel (cPanel or similar):

1. **Login to cPanel:**
   - Open your web browser and navigate to your cPanel login page.
   - Enter your username and password to log in.

2. **Access DNS Zone Editor:**
   - In the cPanel dashboard, look for the "Domains" section.
   - Click on "Zone Editor" or "DNS Zone Editor".

3. **Check DNS Records:**
   - Locate the domain `time.bpsi.us`.
   - Ensure that the A record points to the correct IP address (e.g., `3.109.238.229`).
   - If there is an IPv6 address, ensure the AAAA record points to the correct IPv6 address (e.g., `64:ff9b::36d:eee5`).

4. **Add or Edit DNS Records:**
   - If the records are missing or incorrect, add or edit the A and AAAA records.
   - **A Record:**
     - Name: `time.bpsi.us`
     - Type: `A`
     - Address: `3.109.238.229`
   - **AAAA Record:**
     - Name: `time.bpsi.us`
     - Type: `AAAA`
     - Address: `64:ff9b::36d:eee5`
   - Save the changes.

### Verify the Changes:

- **Wait for Propagation:**
  - DNS changes may take some time to propagate across the internet. This can vary from a few minutes to up to 24-48 hours.
  
- **Re-check DNS Resolution:**
  - After some time, repeat the DNS resolution check using `nslookup` or `dig` to ensure the domain resolves correctly to the IP address.

By following these steps, you should be able to resolve the DNS issue and ensure that `time.bpsi.us` correctly points to the intended IP address. If issues persist, you may need to contact your web hosting provider for further assistance.
