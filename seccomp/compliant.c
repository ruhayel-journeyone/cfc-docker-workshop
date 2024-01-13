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
