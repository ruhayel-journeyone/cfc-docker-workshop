# Example: Creating a new mount namespace

In this example, we'll create a new mount namespace, mount a temporary filesystem, and then verify that this mount is only visible within the namespace.

This example involves the following steps:

1. **Creating a New Namespace**: We'll use the `unshare` command to create a new mount namespace.
2. **Mounting a Filesystem**: Inside the new namespace, we'll mount a temporary filesystem (like a `tmpfs`) on a directory.
3. **Verification**: We'll verify that this mount is only visible within the namespace and not in the global namespace.

Let's go through the code:

## Step 1: Open a Terminal

First, open a terminal on your Linux machine.

### Step 2: Create a New Mount Namespace and Shell

Run the following command to create a new mount namespace and start a new shell in that namespace:

```bash
sudo unshare --mount --fork /bin/bash
```

You are now in a new shell with a new mount namespace.

## Step 3: Create a Mount Point and Mount a Filesystem

Inside the new namespace, create a directory and mount a `tmpfs` filesystem on it:

```bash
mkdir /mnt/mytempfs
mount -t tmpfs tmpfs /mnt/mytempfs
```

## Step 4: Verify the Mount in the New Namespace

You can check the mounts in this new namespace:

```bash
mount | grep mytempfs
```

This should show you the `tmpfs` mounted on `/mnt/mytempfs`.

## Step 5: Exit the Namespace and Check from the Global Namespace

Exit the new namespace shell by typing `exit`. Now, you're back in your original shell. Check the mounts again:

```bash
mount | grep mytempfs
```

You should see that `/mnt/mytempfs` is not listed, indicating it was only mounted in the new mount namespace.

## What Just Happened?

- By running `unshare`, you created a new mount namespace and started a shell within it.
- Inside this namespace, you mounted a temporary filesystem, which was only visible within this namespace.
- After exiting back to the global namespace, the mount was not visible, showing the isolation provided by the mount namespace.

## Note

- This is a basic example. In practice, mount namespaces are often used in more complex scenarios, especially in containerization.
- Ensure you have appropriate permissions or use `sudo` as needed.
- Be cautious with the `mount` and `unshare` commands, as incorrect usage can affect your system.