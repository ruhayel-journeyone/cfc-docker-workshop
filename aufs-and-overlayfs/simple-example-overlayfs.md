# Simple Example: OverlayFs

In this example, let's consider two directories: `lowerdir` and `upperdir`. The `lowerdir` is a read-only layer, and the `upperdir` is a writable layer. Any changes made in the overlay are written to the `upperdir`, while the `lowerdir` remains unchanged.

## Step-by-Step OverlayFS Example

1. **Create Required Directories**:
   - `lowerdir`: Contains initial files.
   - `upperdir`: Where changes are written.
   - `workdir`: A working directory for OverlayFS (must be empty).
   - `merged`: The mount point for the OverlayFS.

   ```bash
   mkdir /tmp/lowerdir /tmp/upperdir /tmp/workdir /tmp/merged
   ```

2. **Add Files to Lower Directory**:
   Populate the `lowerdir` with some files.

   ```bash
   echo "Original file in lowerdir" > /tmp/lowerdir/lowerfile.txt
   ```

3. **Mount the Overlay Filesystem**:
   Use the `mount` command to create an overlay of these directories.

   ```bash
   sudo mount -t overlay -o lowerdir=/tmp/lowerdir,upperdir=/tmp/upperdir,workdir=/tmp/workdir overlay /tmp/merged
   ```

   This command mounts the overlay filesystem at `/tmp/merged`, with `lowerdir` as the base and `upperdir` as the layer that receives any modifications.

4. **Verify Unified View**:
   Now, if you check the contents of `/tmp/merged`, you should see the files from `lowerdir`.

   ```bash
   ls /tmp/merged
   ```

   You should see `lowerfile.txt`.

5. **Modifying Files in the Overlay**:
   When you modify or add files in the `merged` directory, these changes are reflected in `upperdir`, leaving `lowerdir` untouched.

   ```bash
   echo "New file in overlay" > /tmp/merged/overlayfile.txt
   ```

   This file appears in `merged` and is actually stored in `upperdir`.

6. **Checking the Upper Directory**:
   If you look in the `upperdir`, you'll find the new or modified files.

   ```bash
   ls /tmp/upperdir
   ```

   You should find `overlayfile.txt` or corresponding files representing changes to existing files.

7. **Unmounting the Overlay Filesystem**:
   Once done, you can unmount the overlay filesystem.

   ```bash
   sudo umount /tmp/merged
   ```

8. **Remove Temporary Files and Directories**:
   After unmounting, you can safely remove all the temporary directories and their contents.

   ```bash
   rm -rf /tmp/lowerdir /tmp/upperdir /tmp/workdir /tmp/merged
   ```

This example demonstrates the basic functionality of OverlayFS, where changes made in the merged view are stored separately from the original files, allowing for non-destructive modifications and a combination of multiple filesystem layers. OverlayFS is especially useful for systems where a base system needs to remain unchanged (like in live systems or containers) while still allowing for user modifications.

### Notes

- Step 3 requires sudo permissions because mounting filesystems typically requires administrative privileges.
- Always ensure that the OverlayFS is unmounted (Step 7) before attempting to delete the directories (Step 8) to avoid any filesystem errors.
- The cleanup step (Step 8) completely removes all the directories and files created during this process, so make sure any needed data is backed up before performing this step.
