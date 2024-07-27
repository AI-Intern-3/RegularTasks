Updating an SSL certificate in cPanel involves a few straightforward steps. Here’s a step-by-step guide:

### Step 1: Purchase and Obtain the SSL Certificate
1. **Purchase SSL**: Buy an SSL certificate from a trusted provider if you haven’t already.
2. **Generate CSR**: Use cPanel to generate a Certificate Signing Request (CSR) which will be required by the SSL provider.
   - Log in to cPanel.
   - Navigate to the **Security** section.
   - Click on **SSL/TLS**.
   - Click on **Generate, view, or delete SSL certificate signing requests**.
   - Fill in the required details and generate the CSR.
3. **Submit CSR**: Submit the CSR to your SSL provider to get your SSL certificate files.

### Step 2: Install the SSL Certificate
1. **Log in to cPanel**: Access your cPanel account.
2. **Navigate to SSL/TLS**:
   - Go to the **Security** section.
   - Click on **SSL/TLS**.
3. **Manage SSL Sites**:
   - Click on **Manage SSL sites** under the **Install and Manage SSL for your site (HTTPS)** section.
4. **Install Certificate**:
   - In the **Domain** dropdown, select the domain you are installing the SSL certificate for.
   - **Certificate (CRT)**: Copy and paste the SSL certificate provided by your SSL issuer into the **Certificate (CRT)** field.
   - **Private Key (KEY)**: This should be automatically filled in if you generated the CSR in cPanel. If not, paste the private key you received during CSR generation.
   - **Certificate Authority Bundle (CABUNDLE)**: Paste the CA bundle provided by your SSL issuer into this field.
5. **Install Certificate**: Click the **Install Certificate** button to complete the installation.

### Step 3: Verify the Installation
1. **Browser Check**: Open your website in a browser using `https://` and check if the SSL certificate is properly installed.
2. **SSL Checker**: Use online tools like SSL Checker to verify the SSL installation.



### Step 4: Check and Renew Before Expiry
1. **Check Expiry**: Regularly check the expiration date of your SSL certificate.
2. **Renew Certificate**: Renew the SSL certificate before it expires by following the same process above.

