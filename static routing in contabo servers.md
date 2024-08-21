Here’s the step-by-step guide rewritten using the IP addresses `94.136.186.169` and `94.136.185.145`.

### Step 1: Backup the Netplan Configuration File
Before making any changes, back up the existing Netplan configuration file.

```bash
sudo cp /etc/netplan/01-netcfg.yaml /etc/netplan/01-netcfg.yaml.bak
```

### Step 2: Edit the Netplan Configuration File
Open the Netplan configuration file with a text editor.

```bash
sudo nano /etc/netplan/01-netcfg.yaml
```

### Step 3: Add the Static Routes
Locate the section for `eth0` and add the routes under the correct indentation.

Example entry:

```yaml
network:
    version: 2
    renderer: networkd
    ethernets:
        eth0:
            dhcp4: yes
            routes:
                - to: 94.136.186.128/25
                  via: 94.136.186.1
                - to: 94.136.185.128/25
                  via: 94.136.185.1
```

Make sure the indentation is correct to avoid YAML syntax errors.

### Step 4: Validate the Configuration
Validate the configuration before applying it.

```bash
sudo netplan try
```

This will test the new configuration and revert it if something goes wrong.

### Step 5: Apply the Changes Securely
Apply the new routes with the following command to prevent network connectivity loss:

```bash
sudo ip route flush table main; sudo ip route flush cache; sudo netplan apply
```

### Step 6: Verify the Routes
Check that the routes have been added correctly.

```bash
ip route
```

### Step 7: Monitor the Network
Ensure that the network interface `eth0` is up and running and that there is no connectivity loss.

```bash
ping -c 4 94.136.186.1
```

### Step 8: Revert Changes if Needed
If something went wrong, revert to the original configuration using the backup file.

```bash
sudo cp /etc/netplan/01-netcfg.yaml.bak /etc/netplan/01-netcfg.yaml
sudo netplan apply
```

By following these steps, you can securely add static routes for the IP addresses `94.136.186.169` and `94.136.185.145` to the `eth0` interface without disrupting network connectivity on your Ubuntu server.