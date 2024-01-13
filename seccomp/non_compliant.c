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
