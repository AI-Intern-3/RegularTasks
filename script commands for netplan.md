Here's a revised step-by-step guide for setting up static routing with backup on Ubuntu (version 17.10 and above) using a `/24` subnet:

---

### Step-by-Step Instructions for Static Routing with Backup (Using `/24` Subnet):

1. **Access the Server**:
   - SSH into your Contabo server (IP `192.51.100.10`).

   ```bash
   ssh user@192.51.100.10
   ```

2. **Backup the Current Netplan Configuration**:
   - Before making any changes, create a backup of the current Netplan configuration file.

   ```bash
   sudo cp /etc/netplan/01-netcfg.yaml /etc/netplan/01-netcfg.yaml.bak
   ```

3. **Edit the Netplan Configuration File**:
   - Open the `/etc/netplan/01-netcfg.yaml` file using a text editor.

   ```bash
   sudo nano /etc/netplan/01-netcfg.yaml
   ```

4. **Add Static Routes**:
   - Add the static routes under the `eth0` interface using a `/24` subnet. Ensure proper indentation:

   ```yaml
   network:
     version: 2
     renderer: networkd
     ethernets:
       eth0:
         dhcp4: true
         routes:
           - to: 94.136.185.0/24
             via: 94.136.185.145
           - to: 94.136.186.0/24
             via: 94.136.186.169
   ```

5. **Save and Exit**:
   - Save the file and exit the editor (`Ctrl+X` in nano, then `Y` and `Enter`).

6. **Test the Netplan Configuration Using `netplan try`**:
   - Use `netplan try` to test the changes temporarily for 120 seconds. This ensures that the configuration will revert automatically if something goes wrong.

   ```bash
   sudo ip route flush table main; sudo ip route flush cache; sudo netplan try
   ```

   - If everything works fine, confirm the changes by typing:

   ```bash
   yes
   ```

7. **Verify Routing**:
   - After confirming, check if the routing has been successfully applied:

   ```bash
   ip route
   ```

8. **Revert to the Original Netplan Configuration (if needed)**:
   - If there are issues, you can easily revert to the original configuration by restoring the backup:

   ```bash
   sudo cp /etc/netplan/01-netcfg.yaml.bak /etc/netplan/01-netcfg.yaml
   sudo netplan apply
   ```

### Command Summary:

- **Backup** current configuration:
  ```bash
  sudo cp /etc/netplan/01-netcfg.yaml /etc/netplan/01-netcfg.yaml.bak
  ```

- **Edit Netplan file**:
  ```bash
  sudo nano /etc/netplan/01-netcfg.yaml
  ```

- **Test the new configuration**:
  ```bash
  sudo ip route flush table main; sudo ip route flush cache; sudo netplan try
  ```

- **Confirm the changes**:
  ```bash
  yes
  ```

- **Revert to original configuration (if needed)**:
  ```bash
  sudo cp /etc/netplan/01-netcfg.yaml.bak /etc/netplan/01-netcfg.yaml
  sudo netplan apply
  ```

---

This setup ensures you use a `/24` subnet for static routing while providing a backup and testing mechanism to prevent potential network issues.
