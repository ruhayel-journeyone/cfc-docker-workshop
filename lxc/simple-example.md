# Simple Working Example for LXC

1. **Install LXC:**

   ```bash
   sudo apt-get install lxc
   ```

2. **Create a Container:**
   - Let's create an Ubuntu container named 'example-container':

     ```bash
     sudo lxc-create -t download -n example-container -- -d ubuntu -r focal -a amd64
     ```

3. **Start the Container:**

   ```bash
   sudo lxc-start -n example-container
   ```

4. **Attach to the Container:**

   ```bash
   sudo lxc-attach -n example-container
   ```

   - This will drop you into the container's shell.
5. **Stopping the Container:**
   - Exit the container shell.
   - Stop the container:

     ```bash
     sudo lxc-stop -n example-container
     ```
