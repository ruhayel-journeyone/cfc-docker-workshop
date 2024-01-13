# Containers and Images

In Docker, containers and images are fundamental concepts.

## Images

An image is a lightweight, standalone, executable package that includes everything needed to run a piece of software, including the code, runtime, libraries, and settings.

## Containers

Containers are instances of Docker images that run the applications. They provide a complete filesystem, containing everything needed to execute the code, isolated from the underlying system.

Containers rely on technologies like Linux namespaces and cgroups for resource isolation and management, ensuring that each container operates independently and has access to only the resources it needs.
