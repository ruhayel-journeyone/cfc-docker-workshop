# Example: Limiting memory usage using cgroups

## Step 1: Check if cgroups are enabled

First, check if cgroups are enabled on your system. Open a terminal and run:

```bash
lscgroup
```

If you get an output listing various control groups, then cgroups are enabled. If not, you might need to install or enable them.

If cgroups don't seem to be enabled or fully configured on your Linux Mint system, you can follow these steps to enable and configure them:

### Step 1.1: Install cgroup Tools

First, install the necessary cgroup tools. Open your terminal and run:

```bash
sudo apt-get update
sudo apt-get install cgroup-tools
```

This will install `cgroup-tools`, which includes utilities like `lscgroup`, `cgcreate`, and `cgclassify`.

## Step 2: Create a new cgroup

Create a new cgroup named `example_group`:

```bash
sudo mkdir /sys/fs/cgroup/example_group
```

## Step 3: Set a Memory Limit

Set a memory limit for the group. To limit it to 10MB, run:

```bash
echo 10M | sudo tee /sys/fs/cgroup/example_group/memory.max
```

## Step 4: Create a Python Script to Consume Memory

Create a Python script `memory_consumer.py` with the following content:

```python
import time

increment = 10 * 1024 * 1024  # 10 MB
memory_hog = bytearray()

while True:
    memory_hog.extend(bytearray(increment))
    print(f"Used memory: {len(memory_hog)/1024/1024} MB")
    time.sleep(1)
```

## Step 5: Run the Python Script in the Background

Execute the Python script in the background:

```bash
python memory_consumer.py &
```

Note down the PID of this background process:

```bash
echo $!
```

## Step 6: Add the Python Process to the cgroup

Add the Python process to your cgroup using its PID:

```bash
echo [PID] | sudo tee -a /sys/fs/cgroup/example_group/cgroup.procs
```

Replace `[PID]” with the actual process ID you noted.

## Step 7: Observing the Behavior

- **Monitor Memory Usage**: You can monitor the `memory.current` file in the cgroup directory to see how much memory is being used by processes in the cgroup.

  ```bash
  cat /sys/fs/cgroup/example_group/memory.current
  ```

- **Watch for OOM Killer Activation**: If the script exceeds the memory limit, the Out of Memory (OOM) killer should eventually terminate it to keep the system stable. Check `dmesg` or system logs for OOM killer messages.

  ```bash
  dmesg | grep -i "oom"
  ```

- **Script Output**: Observe the output of the Python script. It should eventually stop when the process is killed or unable to allocate more memory.

## Step 8: Remove the cgroup (Optional)

Remove the cgroup:

```bash
sudo rmdir /sys/fs/cgroup/example_group
```
