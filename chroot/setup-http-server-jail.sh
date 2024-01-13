#!/bin/bash

# Exit on error
set -e

# Get the UID and GID of the user executing the script
uid=$(id -u)
gid=$(id -g)
username=$(id -un)

# Directory for the new root
newroot="./newroot-http-server"

# Desired port for lighttpd to bind to
desired_port="8080"

# Function to clean up
cleanup() {
    echo "Cleaning up..."
    # Add cleanup commands here if necessary
    ls -al .
    rm -rf $newroot
}

# Trap to call cleanup function on error or interrupt
trap cleanup ERR INT

# Create necessary directories
mkdir -p $newroot
mkdir -p $newroot/{bin,lib,lib64,usr,home,tmp,var/www,sbin,etc/groupadd,etc/useradd}
chmod 1777 $newroot/tmp

# Create /dev directory in newroot
mkdir -p $newroot/dev
# Create the /dev/null device
sudo mknod -m 666 $newroot/dev/null c 1 3

# Create an uploads directory
mkdir -p $newroot/var/cache/lighttpd/uploads
 
 #Create a run directory for .pid file(s)
 mkdir -p $newroot/run

 # Create log directory
mkdir -p $newroot/var/log/lighttpd

# Create an empty log file
touch $newroot/var/log/lighttpd/error.log


# Locate and copy lighttpd modules
lighttpd_mod_dir="/usr/lib/lighttpd"
if [ -d "$lighttpd_mod_dir" ]; then
    mkdir -p $newroot$lighttpd_mod_dir
    cp $lighttpd_mod_dir/*.so $newroot$lighttpd_mod_dir
else
    echo "Error: lighttpd module directory not found."
    exit 1
fi

# Function to copy binary and its dependencies
copy_binary_and_dependencies() {
    local binary=$1
    # Copy binary
    cp --parents $binary $newroot

    # Find and copy dependencies
    local dependencies=$(ldd $binary | awk 'BEGIN{ORS=" "}$3~/^\//{print $3} /ld-linux/{print $1}')

    for dep in $dependencies; do
        cp --parents $dep $newroot
    done
}

# Install lighttpd (if not installed)
which lighttpd >/dev/null || sudo apt-get install -y lighttpd

# Copy lighttpd binary and dependencies
binaries=("/bin/bash" "/bin/ls" "/bin/cat" "/bin/mkdir" "/usr/sbin/lighttpd" "/usr/sbin/groupadd" "/usr/sbin/useradd")

# Copy each binary and its dependencies
for binary in ${binaries[@]}; do
    copy_binary_and_dependencies $binary
done

# Set up a basic HTML file
echo "<html><body><h1>Welcome to the HTTP server in chroot!</h1></body></html>" > $newroot/var/www/index.html

# Copy lighttpd configuration files
mkdir -p $newroot/etc/lighttpd
cp -rv /etc/lighttpd $newroot/etc

# Create a user and group inside the chroot with the same UID and GID as the executing user
echo "$username:x:$uid:$gid:$username user:/home/$username:/bin/bash" > $newroot/etc/passwd
echo "$username:x:$gid:" > $newroot/etc/group


# Update the server.document-root in lighttpd configuration and disable IPv6 support
conf_file="$newroot/etc/lighttpd/lighttpd.conf"
if [ -f "$conf_file" ]; then
    sed -i 's|server.document-root.*|server.document-root = "/var/www"|' $conf_file
    sed -i '/use-ipv6.pl/d' $conf_file  # Remove IPv6 support
    sed -i '/create-mime.conf.pl/d' $conf_file  # Remove reference to create-mime.conf.pl
    sed -i "s|server.port.*|server.port = $desired_port|" $conf_file
    # Configure lighttpd to run with the UID and GID of the current user
    sed -i "s|server.username.*|server.username = \"$username\"|" $conf_file
    sed -i "s|server.groupname.*|server.groupname = \"$username\"|" $conf_file
    # Create mime.conf
    cat <<EOF > $newroot/etc/lighttpd/mime.conf
# MIME type configuration
mimetype.assign = (
  ".html" => "text/html",
  ".txt" => "text/plain",
  ".jpg" => "image/jpeg",
  ".png" => "image/png"
  # Add more MIME types as needed
)
EOF
else
    echo "Error: lighttpd.conf not found in chroot environment."
    exit 1
fi

# Starting the server
echo "To start the HTTP server in chroot, run:"
echo "sudo chroot $newroot /usr/sbin/lighttpd -D -f /etc/lighttpd/lighttpd.conf"

echo "HTTP server setup in chroot is complete."
