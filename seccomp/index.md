# Secure Computing Mode - seccomp

Seccomp, short for Secure Computing Mode, is a security feature in the Linux kernel that restricts the system calls a process can make. It's a powerful tool for isolating programs and enhancing the security of systems. Here's an overview of how it works, with examples:

## How Seccomp Works

1. **Basic Concept**: Seccomp allows a process to voluntarily restrict the system calls it's allowed to make. Once a set of rules is applied to a process, attempting to use any other system calls will typically result in the process being terminated, or an error being returned.

2. **Modes**:
   - **Strict Mode**: Only read, write, exit, and sigreturn system calls are allowed. This mode is rarely used due to its extreme limitations.
   - **Filter Mode**: This is the more flexible mode where a process can specify a filter that defines which system calls are allowed or denied.

3. **Using Filters**: Filters are defined using Berkeley Packet Filter (BPF) syntax. This allows for complex rulesets.