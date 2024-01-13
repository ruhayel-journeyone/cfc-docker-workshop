### Overview

The two examples provided are C programs demonstrating the use of the Linux kernel's seccomp (Secure Computing Mode) feature for enhancing security. Seccomp is a mechanism for filtering system calls made by a process, reducing the risk of security vulnerabilities.

We have two programs:

1. **Compliant Program**: Uses only system calls allowed by the seccomp filter (`read`, `write`, and `exit`).
2. **Non-Compliant Program**: Attempts a system call (`open` or `openat`) not permitted by the seccomp filter.

### How the Programs Work

#### 1. Compliant Program

This program reads data from standard input and writes it back to standard output. It adheres to the seccomp rules set, running without issues under seccomp.

**Source Code Snippet:**

```c
#include <seccomp.h>
#include <unistd.h>
#include <stdlib.h>

int main() {
    scmp_filter_ctx ctx;
    char buffer[128];
    ssize_t bytes_read;

    // Initialize the seccomp context
    ctx = seccomp_init(SCMP_ACT_ALLOW); // Default action: allow

    // Deny potentially dangerous system calls
    seccomp_rule_add(ctx, SCMP_ACT_KILL, SCMP_SYS(execve), 0);
    seccomp_rule_add(ctx, SCMP_ACT_KILL, SCMP_SYS(fork), 0);
    seccomp_rule_add(ctx, SCMP_ACT_KILL, SCMP_SYS(vfork), 0);
    // Apply the seccomp filter
    seccomp_load(ctx);

    // Compliant program functionality
    bytes_read = read(STDIN_FILENO, buffer, sizeof(buffer) - 1);
    if (bytes_read > 0) {
        write(STDOUT_FILENO, buffer, bytes_read);
    }

    // Release the seccomp context
    seccomp_release(ctx);
    return 0;
}
```

#### 2. Non-Compliant Program

Attempts to open a file, a system call blocked by our seccomp rules. When run under seccomp, the OS terminates it upon executing the forbidden call.

**Source Code Snippet:**

```c
#include <seccomp.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>

int main() {
    scmp_filter_ctx ctx;
    int fd;

    // Initialize the seccomp context
    ctx = seccomp_init(SCMP_ACT_ALLOW); // Default action: allow

    // Deny potentially dangerous system calls
    seccomp_rule_add(ctx, SCMP_ACT_KILL, SCMP_SYS(execve), 0);
    seccomp_rule_add(ctx, SCMP_ACT_KILL, SCMP_SYS(fork), 0);
    seccomp_rule_add(ctx, SCMP_ACT_KILL, SCMP_SYS(vfork), 0);
    // Add other rules as needed
    seccomp_rule_add(ctx,SCMP_ACT_KILL, SCMP_SYS(openat),0);

    // Apply the seccomp filter
    seccomp_load(ctx);

    // Non-compliant program functionality
    fd = open("test.txt", O_RDONLY);
    if (fd >= 0) {
        close(fd);
    }

    // Release the seccomp context
    seccomp_release(ctx);
    return 0;
}
```

### Seccomp Rules

Both programs set up seccomp rules:

- Initialization of a seccomp context with a default action. For the compliant program, it's to kill the process if a disallowed call is tried. For the non-compliant program, all calls are allowed except a few explicitly denied (`execve`, `fork`, `vfork`, and `open`/`openat`).

- Activation of seccomp filters.

### Compilation and Running the Programs

#### Prerequisites

- A Linux system with gcc.
- The libseccomp library installed.

#### Compilation

Use the Makefile for easy compilation. It compiles each program into a `bin` directory.

- Run `make` to compile both programs.

#### Running the Programs

- **Compliant Program**: `make run_compliant` compiles and runs it. You can input text and receive an echo.
- **Non-Compliant Program**: `make run_non_compliant` compiles and runs it. It will be stopped upon trying a forbidden system call.

### Makefile Usage

- `make`: Compiles both programs, placing executables in `bin`.
- `make run_compliant`: Runs the compliant program.
- `make run_non_compliant`: Runs the non-compliant program.
- `make clean`: Removes compiled executables and `bin`.

### Understanding the Output

- **Compliant Program**: Interact by typing text, receiving an echo.
- **Non-Compliant Program**: No interaction or output; it's terminated on a forbidden call.

### Conclusion

These examples show how seccomp controls system calls in Linux programs. The compliant program operates within set restrictions, while the non-compliant one is terminated for violating these rules, illustrating a secure computing approach for sensitive contexts.
