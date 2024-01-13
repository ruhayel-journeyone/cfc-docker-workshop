# Dockerfile commands

Dockerfiles are scripts composed of various commands that automate the creation of Docker images. Here are some of the most popular commands used in Dockerfiles, along with examples and comparisons:

### 1. `FROM`

- **Purpose**: Specifies the base image from which you are building.
- **Example**: `FROM ubuntu:18.04`
- **Comparison**: This is a unique command with no direct alternative.

### 2. `RUN`

- **Purpose**: Executes commands in a new layer on top of the current image and commits the results.
- **Example**: `RUN apt-get update && apt-get install -y git`
- **Comparison**:
  - Similar to `CMD` and `ENTRYPOINT`, but `RUN` is executed during the build process, not when the container starts.

### 3. `CMD`

- **Purpose**: Provides defaults for an executing container. If there are multiple `CMD` instructions, only the last one takes effect.
- **Example**: `CMD ["echo", "Hello World"]`
- **Comparison**:
  - `ENTRYPOINT` is similar but allows you to set the container to run as an executable.

### 4. `ENTRYPOINT`

- **Purpose**: Configures a container that will run as an executable.
- **Example**: `ENTRYPOINT ["top", "-b"]`
- **Comparison**:
  - Different from `CMD` as it allows a container to run as an executable and parameters passed to `docker run <image>` will be appended.

### 5. `COPY`

- **Purpose**: Copies new files or directories from the source and adds them to the filesystem of the container at the destination.
- **Example**: `COPY . /app`
- **Comparison**:
  - `ADD` is similar but also supports tar extraction and remote URL handling.

### 6. `ADD`

- **Purpose**: Copies files from a source to the container's file system at a specified path, with added features like tar extraction.
- **Example**: `ADD ./example.tar.gz /usr/src/app/`
- **Comparison**:
  - `COPY` is recommended for simple copying as it's more transparent.

### 7. `EXPOSE`

- **Purpose**: Informs Docker that the container listens on the specified network ports at runtime.
- **Example**: `EXPOSE 80`
- **Comparison**:
  - This is a unique command with no direct alternative.

### 8. `ENV`

- **Purpose**: Sets environment variables.
- **Example**: `ENV APP_HOME /app`
- **Comparison**:
  - This is a unique command with no direct alternative.

### 9. `WORKDIR`

- **Purpose**: Sets the working directory for any `RUN`, `CMD`, `ENTRYPOINT`, `COPY`, and `ADD` commands that follow in the Dockerfile.
- **Example**: `WORKDIR /app`
- **Comparison**:
  - This is a unique command with no direct alternative.

### 10. `VOLUME`

- **Purpose**: Creates a mount point with the specified name and marks it as holding externally mounted volumes from the native host or other containers.
- **Example**: `VOLUME /data`
- **Comparison**:
  - This is a unique command with no direct alternative.

### 11. `ARG`

- **Purpose**: Defines a variable that users can pass at build-time to the builder with the `docker build` command.
- **Example**: `ARG VERSION=1.0`
- **Comparison**:
  - This is a unique command with no direct alternative.

### 12. `USER`

- **Purpose**: Sets the username or UID to use when running the image.
- **Example**: `USER myuser`
- **Comparison**:
  - This is a unique command with no direct alternative.

### 13. `LABEL`

- **Purpose**: Adds metadata to an image as a key-value pair.
- **Example**: `LABEL version="1.0"`
- **

Comparison**:

- This is a unique command with no direct alternative.

### 14. `HEALTHCHECK`

- **Purpose**: Tells Docker how to test a container to check that it is still working.
- **Example**: `HEALTHCHECK CMD curl --fail http://localhost:80/ || exit 1`
- **Comparison**:
  - This is a unique command with no direct alternative, providing a way for Docker to automatically check the health of containers.

### 15. `ONBUILD`

- **Purpose**: Adds a trigger instruction to be executed at a later time, when the image is used as the base for another build.
- **Example**: `ONBUILD RUN /usr/local/bin/python-build --dir /app/src`
- **Comparison**:
  - This is a unique command that defers the execution of a command until the image is used as a base image.

### 16. `STOPSIGNAL`

- **Purpose**: Sets the system call signal that will be sent to the container to exit.
- **Example**: `STOPSIGNAL SIGTERM`
- **Comparison**:
  - This is a unique command, providing a way to define how to gracefully stop a container.

### Summary

Each of these Dockerfile commands serves a specific purpose in the image creation process. Commands like `RUN`, `CMD`, and `ENTRYPOINT` are often compared because they all deal with executing commands, but each has its own context and behavior. `COPY` and `ADD` are similar but have different capabilities, with `COPY` being preferred for simple file copying. Other commands like `FROM`, `EXPOSE`, `ENV`, `WORKDIR`, `VOLUME`, `ARG`, `USER`, `LABEL`, `HEALTHCHECK`, `ONBUILD`, and `STOPSIGNAL` have unique functions that are essential for different aspects of Docker image configuration and management.
