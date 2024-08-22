To minimize the risk of network downtime, we can use `netplan try`, which tests the new configuration for 120 seconds. If the network becomes unreachable or something goes wrong, the configuration will automatically revert back. Here's an updated step-by-step process using `netplan try`:

### Step-by-Step Instructions Using `netplan try`:

1. **Access the Server**:
   - SSH into your Contabo server (with IP `192.51.100.10`).

   ```bash
   ssh user@192.51.100.10
   ```

2. **Backup the Current Netplan Configuration**:
   - Before making any changes, create a backup of the current Netplan configuration file to revert if needed.

   ```bash
   sudo cp /etc/netplan/01-netcfg.yaml /etc/netplan/01-netcfg.yaml.bak
   ```

3. **Edit the Netplan Configuration File**:
   - Open the `/etc/netplan/01-netcfg.yaml` file using a text editor such as `nano` or `vi`.

   ```bash
   sudo nano /etc/netplan/01-netcfg.yaml
   ```

4. **Add Static Routes**:
   - Add the static routes under the `eth0` interface. Ensure the correct indentation as shown below:

   ```yaml
   network:
     version: 2
     renderer: networkd
     ethernets:
       eth0:
         dhcp4: true
         routes:
           - to: 94.136.185.128/25
             via: 94.136.185.145
           - to: 94.136.186.128/25
             via: 94.136.186.169
   ```

5. **Save and Exit**:
   - Save the changes and exit the editor (`Ctrl+X`, then press `Y` and `Enter` in `nano`).

6. **Test the Netplan Configuration Using `netplan try`**:
   - Instead of directly applying the changes, test them using `netplan try`. This will apply the configuration temporarily for 120 seconds. If something goes wrong (e.g., loss of network connectivity), the configuration will revert automatically.

   ```bash
   sudo ip route flush table main; sudo ip route flush cache; sudo netplan try
   ```

   - If everything works fine, you will be prompted to confirm the changes before the 120-second timer expires. To confirm, type:

   ```bash
   yes
   ```

7. **Verify the Routing**:
   - Check if the routing has been correctly applied using:

   ```bash
   ip route
   ```

8. **Revert to the Original Configuration (if necessary)**:
   - If there’s an issue, you don’t need to do anything after 120 seconds, as the system will automatically revert to the previous working configuration. However, if you manually want to revert, you can restore the backup:

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

- **Confirm the changes after 120 seconds**:
  ```bash
  yes
  ```

- **Revert manually (if necessary)**:
  ```bash
  sudo cp /etc/netplan/01-netcfg.yaml.bak /etc/netplan/01-netcfg.yaml
  sudo netplan apply
  ```

### Summary:
Using `netplan try` allows you to safely test the network configuration. If there is any problem, the system will automatically revert after 120 seconds, reducing the risk of downtime. Make sure to confirm the configuration if everything works fine within the 120-second window.
