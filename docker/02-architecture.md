# Architecture

![Docker Architecture](images/docker-architecture.webp)

The Docker architecture consists of several key components:

1. **Docker Daemon**: The background service running on the host that manages building, running, and distributing Docker containers.

2. **Docker Client**: The command line tool that allows the user to interact with the Docker daemon.

3. **Docker Images**: Read-only templates used to build containers. Images are used to store and ship applications.

4. **Docker Containers**: Runnable instances of Docker images. Containers isolate and secure your applications in a separate environment.

5. **Docker Registries**: Centralized repositories for storing and sharing Docker images.

6. **Docker Compose**: A tool for defining and running multi-container Docker applications.

Each of these components plays a specific role in the Docker ecosystem, enabling efficient container management and deployment.
