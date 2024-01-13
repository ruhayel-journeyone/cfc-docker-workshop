# History

Docker, as a containerization technology, leverages various underlying technologies to create isolated environments (containers) that can run applications securely and efficiently.

Here'show each of the previously mentioned technologies contributes to making Docker possible:

1. **chroot**: Docker uses `chroot` to change the apparent root directory for the processes in a container. This provides a form of isolation by limiting the process's view of the filesystem to a specific directory tree. This is foundational for creating the illusion that each container has its own filesystem.

2. **Mount Namespace**: Mount namespaces are a feature of Linux that Docker uses to provide each container with its own set of filesystem mounts. This means that the processes in each container see a different set of mounted filesystems, further isolating them from each other and from the host system.

3. **seccomp (Secure Computing Mode)**: Docker employs seccomp to restrict the system calls that can be made by a process. This enhances security by limiting the attack surface; even if an attacker compromises a container, they can only make a subset of system calls, potentially preventing them from causing further harm.

4. **cgroups (Control Groups)**: cgroups are used by Docker to limit and isolate the resource usage (CPU, memory, I/O, network, etc.) of containers. This ensures that each container can only use its allocated share of resources, preventing any single container from monopolizing system resources and affecting other containers or the host.

5. **LXC (Linux Containers)**: Originally, Docker used LXC as its default execution environment, which provided a lightweight environment similar to a virtual machine. While Docker has since moved to its own runtime (libcontainer, now part of runc), the principles of containerization established by LXC, such as process isolation and resource allocation, are fundamental to Docker's operation.

6. **User Namespace**: Docker uses user namespaces to map user IDs inside a container to different user IDs on the host system. This means that a process that is running as root inside a container can be mapped to a non-root user on the host, enhancing security by reducing the privileges of container processes on the host system.

Together, these technologies enable Docker to create isolated, secure, and resource-controlled environments for running applications, mimicking the properties of virtual machines but with much higher efficiency and lower overhead.