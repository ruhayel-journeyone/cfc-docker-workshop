# Union Filesystems: AUFS & OverlayFS

OverlayFS and AUFS are both union filesystems, which are used to overlay multiple directories into a single coherent filesystem. They are particularly useful in environments where multiple filesystems need to be combined and managed in a unified way. Let's explore each of them and their relationship to Docker, as well as their similarities and differences.

## OverlayFS

1. **What is OverlayFS?**
   - OverlayFS is a type of union filesystem included in the mainline Linux kernel since version 3.18. It allows the overlaying of one filesystem on top of another, creating a merged view. The lower filesystem is typically read-only, while the upper filesystem is writable.

2. **Use in Docker**:
   - Docker can use OverlayFS as a storage driver. OverlayFS is beneficial for Docker because it allows efficient image and layer handling. When a Docker container is run, it uses an image as its base (lower layer), and any changes made within the container are written to the upper layer. This setup makes container operations faster and more efficient.

## AUFS

1. **What is AUFS?**
   - AUFS (Advanced Multi-Layered Unification Filesystem) is an older union filesystem that allows multiple read-only and writeable filesystem layers. AUFS supports more layers and has more complex features than OverlayFS.

2. **Use in Docker**:
   - Docker initially used AUFS as one of its first storage drivers for managing image layers and containers. AUFS was popular due to its ability to handle multiple layers efficiently, which is a fundamental requirement in Docker's operation.

## Similarities

- **Layered Filesystem**: Both OverlayFS and AUFS are union filesystems that allow multiple directories or filesystems to be overlaid into a single coherent filesystem.
- **Usage in Docker**: They have both been used by Docker as storage drivers, enabling Docker to layer images and container filesystems efficiently.

## Differences

- **Kernel Inclusion**: OverlayFS is included in the mainline Linux kernel, while AUFS is not and requires separate installation and maintenance.
- **Complexity and Features**: AUFS is more complex, offering additional features like writable branch balancing and more layers. OverlayFS, on the other hand, is simpler and generally considered more efficient and stable due to its integration with the Linux kernel.
- **Performance and Stability**: OverlayFS tends to offer better performance and stability, which is why it has become more widely adopted in recent Docker installations.

## Conclusion

In Docker, these filesystems are used as storage drivers to manage container layers. While AUFS was initially popular due to its feature set and flexibility, OverlayFS has become more prevalent in newer Docker installations due to its inclusion in the Linux kernel, simplicity, and reliability. The choice between AUFS and OverlayFS for Docker depends on the specific needs, system compatibility, and performance considerations.
