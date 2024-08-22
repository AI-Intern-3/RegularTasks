To ensure a safe rollback in case something goes wrong, it's important to back up the current Netplan configuration before making any changes. Here's an updated step-by-step guide with the backup process included.

### Step-by-Step Instructions for Static Routing with Backup:

1. **Access the Server**:
   - SSH into your Contabo server (the one with IP `192.51.100.10`).

   ```bash
   ssh user@192.51.100.10
   ```

2. **Backup the Current Netplan Configuration**:
   - Before making any changes, create a backup of the current Netplan configuration file. This allows you to revert if needed.

   ```bash
   sudo cp /etc/netplan/01-netcfg.yaml /etc/netplan/01-netcfg.yaml.bak
   ```

3. **Edit the Netplan Configuration File**:
   - Open the `/etc/netplan/01-netcfg.yaml` file using a text editor such as `nano` or `vi`.

   ```bash
   sudo nano /etc/netplan/01-netcfg.yaml
   ```

4. **Add Static Routes**:
   - Add the following static routes under the `eth0` interface, ensuring the correct indentation:

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
   - Save the file and exit the text editor (`Ctrl+X` in nano, then press `Y` and `Enter`).

6. **Apply the Netplan Configuration**:
   - To safely apply the changes without risking network disconnection, use the following command to flush the routing table and cache before applying the new configuration:

   ```bash
   sudo ip route flush table main; sudo ip route flush cache; sudo netplan apply
   ```

7. **Verify Routing**:
   - After applying the changes, check if the routing is correctly configured:

   ```bash
   ip route
   ```

8. **Revert to the Original Netplan Configuration (if needed)**:
   - If there are any issues after applying the changes, you can easily revert to the original configuration by restoring the backup:

   ```bash
   sudo cp /etc/netplan/01-netcfg.yaml.bak /etc/netplan/01-netcfg.yaml
   sudo netplan apply
   ```

### Summary:
1. **Backup** the original configuration (`cp /etc/netplan/01-netcfg.yaml /etc/netplan/01-netcfg.yaml.bak`).
2. Edit `/etc/netplan/01-netcfg.yaml` to include static routes.
3. Apply the changes with `netplan apply` after flushing the routing table.
4. **Revert** to the backup configuration if needed (`cp /etc/netplan/01-netcfg.yaml.bak /etc/netplan/01-netcfg.yaml`).

This process provides a secure method for adding static routes while allowing a quick rollback to the original settings.





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

Applying network configuration changes using Netplan can lead to a **temporary disruption in network connectivity**, which can cause your websites to go down momentarily. Here are some risks and mitigation strategies:

### Risks Involved:
1. **Temporary Network Downtime**:
   - When you apply changes to the network interface (e.g., adding static routes), the interface may briefly reset as Netplan reconfigures the routing. This could lead to temporary loss of connectivity, potentially affecting your websites.
   
2. **Misconfiguration**:
   - If there's an error in the Netplan configuration file (e.g., incorrect indentation or wrong parameters), it may cause the network interface to not restart properly, leading to longer downtime.

3. **Loss of SSH Access**:
   - If you are connected via SSH while applying these changes and a mistake is made, you might lose SSH access to the server until you fix the configuration through a console or alternative access.

4. **Website Unavailability**:
   - If your server becomes unreachable due to routing or networking issues, your websites may go offline, which could affect users until the problem is resolved.

### Mitigation Strategies:
1. **Apply Changes During Low Traffic**:
   - Plan the changes during a maintenance window or a period of low traffic to minimize the impact on users.

2. **Double-Check the Configuration**:
   - Ensure that the configuration is correct before applying it. Any minor mistake could prevent the network interface from functioning correctly.
   - Use a YAML syntax validator to make sure there are no indentation or format errors in the `/etc/netplan/01-netcfg.yaml` file.

3. **Use a Backup Plan (Revert Quickly)**:
   - Since you’ll create a backup of the current configuration, you can revert back to the original one in case of failure. Make sure you can access the server through a secondary method (like console access from your Contabo control panel) in case SSH becomes unavailable.

4. **Apply Changes without Restarting the Interface**:
   - You can try to **test** the configuration without applying it permanently. For example, instead of using `netplan apply`, you can use:

     ```bash
     sudo netplan try
     ```

     This allows you to test the new network configuration, and if something goes wrong, the configuration will revert after 120 seconds, allowing you to avoid permanent network downtime.

5. **Check Current Connections**:
   - Use the command `ip route` to examine the current routing configuration before applying any changes, ensuring the current routing table aligns with the new routes you're adding.

6. **Multiple Admin Access**:
   - If possible, have a second admin or access method ready to monitor or revert changes in case your primary access (like SSH) is disrupted.

### Summary:
- **Risk**: Temporary network downtime that may affect websites during Netplan changes.
- **Mitigation**: Apply changes during off-peak hours, use `netplan try` to test configurations, and always back up the current setup.
- **Preparation**: Plan for an alternative access method (such as console access) if the SSH connection fails.

With careful planning and backup measures in place, the risk of a significant outage can be minimized. 
