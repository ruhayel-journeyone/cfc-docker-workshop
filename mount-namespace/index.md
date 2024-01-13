# Mount Namespaces

Mount namespaces in Linux are a feature of the Linux kernel that allow for the segregation of mounts in the file system, making them unique to a specific set of processes. This feature is a part of Linux's namespaces functionality, which is central to creating containers in Linux environments like Docker.

Here's a simple explanation with examples:

1. **Default Namespace**: When the system boots up, all processes share the same mount namespace. This means they all see the same file system hierarchy. For instance, what you see in `/mnt` or `/home` is the same across all processes.

2. **Creating a New Mount Namespace**: When a new mount namespace is created (using a command like `unshare` or a system call like `clone()` with specific flags), the processes in this new namespace can have a different view of the file system. This doesn't affect the view of the file system in the original or other namespaces.

   **Example**: Process A is running in the default namespace. Process B creates a new mount namespace and mounts a new file system at `/mnt`. Process A won't see this new file system at `/mnt`; it only exists for Process B and any other process in its namespace.

3. **Isolation and Containers**: This is particularly useful in containerization. Each container can have its own mount namespace, so it can have its own file systems mounted without affecting the host system or other containers. 

   **Example**: Consider two containers, Container1 and Container2. In Container1, you mount a filesystem at `/data`. This mount is invisible to Container2. Similarly, any mounts in Container2 do not affect Container1 or the host.

4. **Persistent and Ephemeral Changes**: Changes made in a mount namespace can be persistent or ephemeral. If you mount a new filesystem in a namespace, it remains until unmounted. But if the namespace is destroyed (like when a container is stopped), the mounts disappear.

   **Example**: In a temporary namespace, you mount a temporary filesystem at `/tmp/newfs`. This filesystem is available as long as the namespace exists. Once the namespace is destroyed, `/tmp/newfs` is no longer mounted or accessible.

5. **Security and Resource Limitation**: Mount namespaces enhance security by limiting what parts of the global filesystem a process can see and modify. It also helps in resource limitation, as each namespace can have its own set of mounts, avoiding clutter and potential conflicts in the global namespace.

Mount namespaces are a powerful tool in Linux, enabling a high degree of isolation and flexibility, particularly in the context of containerized applications and virtualization.