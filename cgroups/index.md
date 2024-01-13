# Control Groups

Control groups, commonly known as cgroups, are a feature of the Linux kernel that allows you to allocate resources—such as CPU time, system memory, network bandwidth, or combinations of these resources—among user-defined groups of tasks (processes) running on a system. Here are some key aspects of cgroups:

1. **Resource Limitation**: You can limit how much of a particular resource (like CPU or memory) a group of processes can use. This helps prevent any single process or user from hogging system resources.

2. **Prioritization**: Cgroups can prioritize the allocation of resources among different groups. This is particularly useful on multi-user systems or servers running multiple services.

3. **Accounting**: Cgroups allow you to monitor the resource usage of different groups, which is important for understanding how resources are being used on the system and for billing purposes in multi-tenant environments.

4. **Control**: Cgroups provide a mechanism to control the execution of a group of processes, including the ability to freeze and restart the group.

Cgroups are extensively used in virtualization, containerization, and cloud computing scenarios to ensure fair and efficient resource usage and isolation. For instance, they are an essential part of how Docker containers limit and monitor the use of system resources for each container.
