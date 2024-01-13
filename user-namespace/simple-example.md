# Updated Example with Checks: Creating a User Namespace and Observing User ID Differences

1. **Open a Terminal**: Access your Linux terminal.

2. **Check Your Current User ID on the Host**:
   - Before entering the new namespace, check your current user ID and group ID by running:

     ```bash
     id
     ```

   - Note the output. It will typically show your regular user's ID and group ID on the host system.

3. **Run the `unshare` Command to Create a New User Namespace**:
   - Execute the following command:

     ```bash
     unshare --fork --pid --mount-proc -U -r bash
     ```

   - This command creates a new user namespace where the root user of the namespace is mapped to your regular user on the host.

4. **Check Your User ID Inside the Namespace**:
   - In the new shell session inside the namespace, run:

     ```bash
     id
     ```

   - The output should show you as the root user (`uid=0` and `gid=0`). This indicates that inside this namespace, you are recognized as the root user, even though you are not the root user on the host system.

5. **Demonstrate Independence and Isolation**:
   - Try performing an action that requires root privileges inside the namespace. For example, creating a directory in a root-owned location:

     ```bash
     mkdir /root/test_dir
     ```

   - This action should fail inside the namespace. While it appears we are the root user in the bash shell, we are actually running as the current non-root user on our host.

6. **Exit the Namespace and Cleanup**:
   - Type `exit` or press `Ctrl+D` to leave the namespace.
   - You are now back in your regular terminal session on the host system.

7. **Verify Host System State**:
   - Run `id` again in your regular terminal. You should see your original user ID and group ID, same as in step 2.