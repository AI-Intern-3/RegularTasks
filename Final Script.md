It looks like the `start-jira.sh` script was not found in the current directory. You need to navigate to the directory where the Jira installation scripts are located before running the script.

Here's how you can do it:

1. **Switch to the Jira user:**
   ```bash
   sudo su - jira
   ```

2. **Navigate to the Jira installation directory:**
   ```bash
   cd /opt/jira/bin
   ```

3. **Run the `start-jira.sh` script:**
   ```bash
   ./start-jira.sh
   ```

If you encounter any errors or issues, please ensure that:

- The Jira tar.gz file was correctly extracted to the installation directory (`/opt/jira` in this example).
- The `start-jira.sh` script exists in the `bin` directory of the installation directory.
- The permissions are set correctly so that the Jira user can execute the script.

You can verify the file's existence by listing the contents of the directory:

```bash
ls -l /opt/jira/bin
```

This should show the `start-jira.sh` script along with other executable files.
