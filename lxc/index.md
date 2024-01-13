# Linux Containers (LXC)

Linux Containers (LXC) is a lightweight virtualization technology that runs multiple isolated Linux system instances (containers) on a single Linux control host. LXC combines the kernel's cgroups and support for isolated namespaces to provide an isolated environment for applications.

## How LXC Works

1. **Isolation:** LXC uses Linux namespaces to provide an isolated environment for each container. Namespaces ensure that each container has its own isolated instance of global resources such as process IDs, network interfaces, etc.
2. **Resource Control:** LXC utilizes cgroups (control groups) to limit, prioritize, and allocate resources like CPU, memory, block I/O, network, etc., for each container.
3. **Root Filesystem:** Each LXC container has its own root filesystem, which is typically a directory on the host machine's filesystem. This root filesystem can be created using tools like `debootstrap`, `yum`, or `pacstrap`, depending on the Linux distribution.
4. **Security:** LXC supports security features like AppArmor and SELinux profiles, providing an additional layer of security to the containers.

## Differences Between LXC and Docker

1. **Level of Abstraction:** Docker provides a higher level of abstraction compared to LXC. Docker focuses on the packaging, deployment, and management of applications, whereas LXC is more about running multiple Linux systems on a host machine.
2. **Portability:** Docker containers are more portable across different systems as they include application dependencies within the container itself.
3. **Image Management:** Docker has a sophisticated image management system with Docker Hub, allowing easy sharing of container images, whereas LXC lacks a native, comprehensive image distribution system.
4. **Application Focus:** Docker is primarily designed for application isolation whereas LXC is suitable for full OS virtualization.
