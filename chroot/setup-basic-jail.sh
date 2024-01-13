#!/bin/bash

# Exit on error
set -e

# Directory for the new root
newroot="/newroot"

# Binaries you want to include
binaries=("bash" "ls" "cat" "mkdir" "rm" "touch" "cd")

# Function to clean up
cleanup() {
    echo "Cleaning up..."
    # Add any necessary cleanup commands here
    # For example, removing temporary files or unmounting file systems
    rm -rf $newroot
}

# Trap to call cleanup function on error or interrupt
trap cleanup ERR INT

# Create necessary directories
mkdir -p $newroot
mkdir -p $newroot/{bin,lib,lib64,usr,home,tmp}
chmod 1777 $newroot/tmp

# Function to copy binary and its dependencies
copy_binary_and_dependencies() {
    local binary=$1
    # Copy binary
    cp --parents /bin/$binary $newroot

    # Find and copy dependencies
    local dependencies=$(ldd /bin/$binary | awk 'BEGIN{ORS=" "}$3~/^\//{print $3} /ld-linux/{print $1}')

    for dep in $dependencies; do
        cp --parents $dep $newroot
    done
}

# Copy each binary and its dependencies
for binary in ${binaries[@]}; do
    copy_binary_and_dependencies $binary
done

echo "Chroot environment setup is complete."
