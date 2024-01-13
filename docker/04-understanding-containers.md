# Understanding Containers

1. **Creating and Running Containers**:
   - **`docker run` Command**: To create and start a new container from an image:

     ```bash
     docker run -d -p 8080:80 my-web-app
     ```

     This command runs a container in detached mode (`-d`), mapping port 8080 on the host to port 80 in the container (`-p 8080:80`), from an image named `my-web-app`.

   - **Interactive Mode**: Run a container interactively, especially useful for shells:

     ```bash
     docker run -it ubuntu bash
     ```

     This starts an Ubuntu container and opens a Bash shell in interactive mode.

2. **Managing Containers**:
   - **Listing Containers**: To list running containers:

     ```bash
     docker ps
     ```

     To see all containers, including stopped ones:

     ```bash
     docker ps -a
     ```

   - **Stopping Containers**: To stop a running container:

     ```bash
     docker stop <container_id>
     ```

   - **Starting, Restarting, and Removing Containers**:
     Start a stopped container:

     ```bash
     docker start <container_id>
     ```

     Restart a container:

     ```bash
     docker restart <container_id>
     ```

     Remove a container:

     ```bash
     docker rm <container_id>
     ```

3. **Inspecting Containers**:
   - **Logs**: To check the logs of a container:

     ```bash
     docker logs <container_id>
     ```

   - **Inspect Command**: To get detailed information about a container:

     ```bash
     docker inspect <container_id>
     ```

4. **Interacting with Running Containers**:
   - **Executing Commands**: To execute a command inside a running container:

     ```bash
     docker exec -it <container_id> bash
     ```

     This opens a Bash shell inside the container.

   - **Attaching to Containers**: Attach your terminal to a running container:

     ```bash
     docker attach <container_id>
     ```

5. **Networking and Port Mapping**:
   - Example of port mapping when starting a container:

     ```bash
     docker run -d -p 8080:80 nginx
     ```

     This runs an Nginx container and maps port 8080 on the host to port 80 in the container.

6. **Managing Container Resources**:
   - Limiting memory usage of a container:

     ```bash
     docker run -d --memory=500m my-app
     ```

     This runs a container with a maximum of 500 megabytes of memory.

7. **Volumes and Data Persistence**:
   - Mounting a volume to persist data:

     ```bash
     docker run -d -v /mydata:/data my-app
     ```

     This mounts the host directory `/mydata` to `/data` inside the container.
