The default location for Java installation on a Linux system, when installed using the package manager as a root user, is typically under the `/usr/lib/jvm/` directory. For example, if you install OpenJDK 11, it would likely be found in a directory like `/usr/lib/jvm/java-11-openjdk-amd64/`.

Here's how you can verify the location of your Java installation:

1. **Install Java (if not already installed):**
   ```bash
   sudo apt update
   sudo apt install openjdk-11-jdk -y
   ```

2. **Find the Java installation directory:**
   ```bash
   readlink -f $(which java)
   ```

   This command will provide the path to the Java executable, which is typically located in the `bin` directory of the JDK installation. For example:
   ```
   /usr/lib/jvm/java-11-openjdk-amd64/bin/java
   ```

3. **Java Home Directory:**
   The Java home directory can be derived by removing the `/bin/java` part of the path:
   ```
   /usr/lib/jvm/java-11-openjdk-amd64/
   ```

4. **Setting JAVA_HOME Environment Variable:**
   It's a common practice to set the `JAVA_HOME` environment variable to point to the Java installation directory. You can add the following line to your `.bashrc` or `.profile` file:
   ```bash
   export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
   export PATH=$JAVA_HOME/bin:$PATH
   ```

5. **Reload the Profile:**
   After editing the profile file, reload it to apply the changes:
   ```bash
   source ~/.bashrc
   ```

By following these steps, you can identify and set the default location for your Java installation on a Linux system.
