# Understanding Docker Images

A Docker image is a lightweight, standalone, executable package that includes everything needed to run a piece of software, including the code, a runtime, libraries, environment variables, and config files.

1. **Layered Architecture**: Docker images consist of layers. Each layer represents an instruction in the image's Dockerfile. For example, one layer might contain your application code, while another contains the Python runtime, another the libraries your app needs, and so on.

2. **Immutable**: Once an image is created, it never changes. Modification creates a new layer over the existing image.

3. **Registry Storage**: Images are stored in a Docker registry such as Docker Hub. They can be downloaded (pulled) and run on any machine with Docker installed.

## Example: Creating a Simple Python Docker Image

Let's create a Docker image for a simple Python application.

#### Step 1: Write a Python Application

First, write a simple Python application. Let's say `app.py`:

```python
# app.py
print("Hello from Docker!")
```

### Step 2: Create a Dockerfile

A Dockerfile contains instructions to build the image. Here's a basic Dockerfile for our Python app:

```Dockerfile
# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Run app.py when the container launches
CMD ["python", "./app.py"]
```

This Dockerfile does the following:

- Starts from a Python 3.8 image.
- Sets the working directory.
- Copies the current directory's contents to the container.
- Sets the command to run the app.

### Step 3: Build the Docker Image

Run the following command in the directory containing your Dockerfile and application:

```bash
docker build -t python-docker-demo .
```

This command builds the Docker image and tags it as `python-docker-demo`.

You should see the following output in your terminal:

```shell
(base) ruraljuror@lamington-lopez:~/code/cfc-docker-workshop/docker/04-resources$ docker build -t python-docker-demo .
[+] Building 11.7s (8/8) FINISHED                                                                                                                                                                                              docker:default
 => [internal] load build definition from Dockerfile                                                                                                                                                                                     0.1s
 => => transferring dockerfile: 329B                                                                                                                                                                                                     0.0s
 => [internal] load .dockerignore                                                                                                                                                                                                        0.1s
 => => transferring context: 2B                                                                                                                                                                                                          0.0s
 => [internal] load metadata for docker.io/library/python:3.8-slim                                                                                                                                                                       4.9s
 => [1/3] FROM docker.io/library/python:3.8-slim@sha256:dc927c886433ecf28f70ba5b659dc5f1b8fa1a47bed65ccb7aa01650169aeb6f                                                                                                                 6.2s
 => => resolve docker.io/library/python:3.8-slim@sha256:dc927c886433ecf28f70ba5b659dc5f1b8fa1a47bed65ccb7aa01650169aeb6f                                                                                                                 0.0s
 => => sha256:b893819ad12f8f8b680b515055e182d807b82876c1b25692eca309e7b2c524a4 1.37kB / 1.37kB                                                                                                                                           0.0s
 => => sha256:25091a2f0163c3f04dcce2ffc8d64f349f5d738215c7fe46cf92b040d5c631bd 6.97kB / 6.97kB                                                                                                                                           0.0s
 => => sha256:2f44b7a888fa005d07c031d3cfad2a1c0344207def2ab9dbb97712425ff812c1 29.13MB / 29.13MB                                                                                                                                         4.4s
 => => sha256:3f00b3697662aa214d22bb76bbbf5fa4d80f7ba9ca9f9076a9440d53bf529b83 3.51MB / 3.51MB                                                                                                                                           0.9s
 => => sha256:fa8b5ed51b617f793487eb8b5c0d947553c6d649eabd5615e35795e71c70feb2 13.75MB / 13.75MB                                                                                                                                         4.3s
 => => sha256:dc927c886433ecf28f70ba5b659dc5f1b8fa1a47bed65ccb7aa01650169aeb6f 1.86kB / 1.86kB                                                                                                                                           0.0s
 => => sha256:26916576c92c435f7441cb7490dd537040d28b42ab2719ea02ba909f0985a57c 243B / 243B                                                                                                                                               1.3s
 => => sha256:a252644cbe8cc10aa96d4972570a568af06236867edf20146b95980844667b2f 3.13MB / 3.13MB                                                                                                                                           2.6s
 => => extracting sha256:2f44b7a888fa005d07c031d3cfad2a1c0344207def2ab9dbb97712425ff812c1                                                                                                                                                0.7s
 => => extracting sha256:3f00b3697662aa214d22bb76bbbf5fa4d80f7ba9ca9f9076a9440d53bf529b83                                                                                                                                                0.1s
 => => extracting sha256:fa8b5ed51b617f793487eb8b5c0d947553c6d649eabd5615e35795e71c70feb2                                                                                                                                                0.3s
 => => extracting sha256:26916576c92c435f7441cb7490dd537040d28b42ab2719ea02ba909f0985a57c                                                                                                                                                0.0s
 => => extracting sha256:a252644cbe8cc10aa96d4972570a568af06236867edf20146b95980844667b2f                                                                                                                                                0.2s
 => [internal] load build context                                                                                                                                                                                                        0.0s
 => => transferring context: 392B                                                                                                                                                                                                        0.0s
 => [2/3] WORKDIR /usr/src/app                                                                                                                                                                                                           0.4s
 => [3/3] COPY . .                                                                                                                                                                                                                       0.1s
 => exporting to image                                                                                                                                                                                                                   0.1s
 => => exporting layers                                                                                                                                                                                                                  0.1s
 => => writing image sha256:270d5e5b3d8cedca1af62f36cec7dd9eea1966ba262b77e868f6da87ae1519b8                                                                                                                                             0.0s
 => => naming to docker.io/library/python-docker-demo     
```

1. **Command Line Input**:

   ```shell
   (base) ruraljuror@lamington-lopez:~/code/cfc-docker-workshop/docker/04-resources$ docker build -t python-docker-demo .
   ```

   - This is the command line input. The user `ruraljuror` is in the directory `~/code/cfc-docker-workshop/docker/04-resources` and runs the Docker build command to build an image named `python-docker-demo` from the current directory.

2. **Build Process Start**:

   ```shell
   [+] Building 11.7s (8/8) FINISHED
   ```

   - Indicates the start and end of the build process, which took 11.7 seconds and completed all 8 steps.

3. **Loading Build Definition**:

   ```shell
   => [internal] load build definition from Dockerfile
   => => transferring dockerfile: 329B
   ```

   - Docker is loading the build instructions from the Dockerfile (329 bytes).

4. **Loading .dockerignore File**:

   ```shell
   => [internal] load .dockerignore
   => => transferring context: 2B
   ```

   - Docker is loading the `.dockerignore` file (2 bytes), which helps to exclude files not needed for the build.

5. **Loading Base Image Metadata**:

   ```shell
   => [internal] load metadata for docker.io/library/python:3.8-slim
   ```

   - Fetching metadata for the base image `python:3.8-slim` from Docker Hub.

6. **Base Image Preparation**:

   ```shell
   => [1/3] FROM docker.io/library/python:3.8-slim@sha256:...
   ```

   - The first of three main Dockerfile steps, pulling the base image `python:3.8-slim`.

7. **Layer Download and Extraction**:
   - Several lines with `=> => sha256:...` and `extracting sha256:...`:
     - These lines represent the layers of the base image being downloaded and then extracted.

8. **Loading Build Context**:

   ```shell
   => [internal] load build context
   => => transferring context: 392B
   ```

   - Loading the build context (392 bytes) into Docker, which includes the files in the current directory minus those matched in `.dockerignore`.

9. **Setting Working Directory in Container**:

   ```shell
   => [2/3] WORKDIR /usr/src/app
   ```

   - The second step in the Dockerfile, setting the working directory inside the Docker container.

10. **Copying Project Files**:

    ```shell
    => [3/3] COPY . .
    ```

    - The third step in the Dockerfile, copying files from the current directory into the container.

11. **Exporting to Image**:

    ```shell
    => exporting to image
    => => exporting layers
    ```

    - Finalizing the image by preparing it for export.

12. **Writing Image SHA256**:

    ```shell
    => => writing image sha256:...
    ```

    - Saving the new image with its unique SHA256 identifier.

13. **Naming the Image**:

    ```shell
    => => naming to docker.io/library/python-docker-demo
    ```

    - Tagging the final image with the name `python-docker-demo`.

In summary, this output details the Docker image building process, which includes loading the Dockerfile, handling the build context, pulling and preparing the base image, setting the working directory, copying files, and finalizing the image by exporting layers and tagging.

### Step 4: Run the Docker Image

To run the image:

```bash
docker run python-docker-demo
```

This should output: `Hello from Docker!`

## Conclusion

This example demonstrates creating a Docker image for a simple Python application. Docker images provide a consistent and isolated environment for applications, ensuring they work uniformly across different systems. The process of building and running a Docker image involves defining the environment and dependencies, building the image, and then running it in a container.
