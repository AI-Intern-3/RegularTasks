To address the SSL/TLS certificate update for your RDS DB instance and ensure an automatic instance restart with a snapshot taken before any modification, follow these steps:

### Step 1: Take a Snapshot of the RDS Instance

1. **Log in to the AWS Management Console.**
2. **Navigate to the RDS Dashboard.**
3. **Select the RDS Instance** you want to update.
4. **Click on “Actions”** and then **“Take snapshot”.**
5. **Enter a name** for your snapshot and click **“Take Snapshot”**.

### Step 2: Update the SSL/TLS Certificate

1. **Log in to the AWS Management Console.**
2. **Navigate to the RDS Dashboard.**
3. **Select the RDS Instance** you want to update.
4. **Click on “Modify”** from the “Actions” menu.
5. **Scroll down to the “Network & Security” section**.
6. **Find the “DB Parameter Group”** and select the parameter group associated with your instance.
7. **In the “DB Parameter Group” settings**, look for the parameter related to SSL/TLS certificates (e.g., `rds.force_ssl`). Update this parameter if necessary.
8. **Scroll to the “Certificate Authority” section**.
9. **Select the new certificate** from the dropdown menu.
10. **Ensure that the “Apply Immediately” option** is selected. This will trigger an automatic restart of the instance.
11. **Click on “Continue”**, review the changes, and then click **“Modify DB Instance”**.

### Step 3: Verify the Changes

1. **Monitor the RDS Instance** to ensure it restarts automatically.
2. **Verify that the new certificate** is in use. You can do this by connecting to your RDS instance and checking the SSL/TLS certificate being used.

### Automating with AWS CLI

To automate the process, you can use the AWS CLI commands. Here's a script to help you:

```bash
# Variables
RDS_INSTANCE_IDENTIFIER="your-rds-instance-id"
SNAPSHOT_NAME="your-snapshot-name"

# Step 1: Take a Snapshot
aws rds create-db-snapshot \
    --db-instance-identifier $RDS_INSTANCE_IDENTIFIER \
    --db-snapshot-identifier $SNAPSHOT_NAME

# Wait for the snapshot to complete
aws rds wait db-snapshot-completed \
    --db-instance-identifier $RDS_INSTANCE_IDENTIFIER \
    --db-snapshot-identifier $SNAPSHOT_NAME

# Step 2: Modify the RDS instance to update SSL/TLS certificate
aws rds modify-db-instance \
    --db-instance-identifier $RDS_INSTANCE_IDENTIFIER \
    --ca-certificate-identifier rds-ca-2019 \
    --apply-immediately

# Wait for the instance to restart
aws rds wait db-instance-available \
    --db-instance-identifier $RDS_INSTANCE_IDENTIFIER

# Step 3: Verify the changes (Optional)
# Connect to the RDS instance and check the SSL/TLS certificate
```

### Notes
- Replace `your-rds-instance-id` with your actual RDS instance identifier.
- Replace `your-snapshot-name` with a meaningful snapshot name.
- `rds-ca-2019` is an example of a certificate identifier. Make sure to use the appropriate certificate identifier for your instance.

By following these steps, you ensure that your RDS instance is updated with the new SSL/TLS certificate and that you have a snapshot taken beforehand for safety.
