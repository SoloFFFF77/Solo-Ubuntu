#!/bin/bash

# Solo-Ubuntu Setup Script
# Installs proot-distro and the base Ubuntu image.

SOLO_UBUNTU_DIR=$(pwd)
SCRIPTS_DIR="$SOLO_UBUNTU_DIR/scripts"

# --- 1. Termux Environment Setup ---
echo "--- 1. Setting up Termux environment ---"
pkg update -y
pkg install proot-distro git wget -y

# --- 2. Install Base Ubuntu ---
echo "--- 2. Installing base Ubuntu using proot-distro ---"
proot-distro install ubuntu

# --- 3. Copy Setup Scripts into Ubuntu ---
echo "--- 3. Copying setup scripts into Ubuntu root filesystem ---"
# Create a temporary directory inside the Ubuntu root to copy files
proot-distro do ubuntu -- bash -c "mkdir -p /root/solo-ubuntu-setup"

# Copy the scripts from the host Termux environment to the Ubuntu environment
cp "$SOLO_UBUNTU_DIR/user.sh" "$SOLO_UBUNTU_DIR/gui.sh" "$SOLO_UBUNTU_DIR/remove.sh" "$SOLO_UBUNTU_DIR/setup.sh" "$SOLO_UBUNTU_DIR/LICENSE" "$SOLO_UBUNTU_DIR/CHANGELOG.md" "$SOLO_UBUNTU_DIR/README.md" "$SOLO_UBUNTU_DIR/assets" -r /root/solo-ubuntu-setup/

# Make them executable and move them to a standard location inside the Ubuntu environment
proot-distro do ubuntu -- bash -c "mv /root/solo-ubuntu-setup/user.sh /usr/local/bin/user.sh"
proot-distro do ubuntu -- bash -c "mv /root/solo-ubuntu-setup/gui.sh /usr/local/bin/gui.sh"
proot-distro do ubuntu -- bash -c "chmod +x /usr/local/bin/user.sh /usr/local/bin/gui.sh"

# --- 4. Create Alias for Easy Access ---
echo "--- 4. Creating 'ubuntu' alias for easy access ---"
# This is typically done by proot-distro, but we ensure it's there.
# We also create a wrapper script to run the user setup on first run.
echo "proot-distro login ubuntu" > "$PREFIX/bin/ubuntu"
chmod +x "$PREFIX/bin/ubuntu"

echo "Solo-Ubuntu base installation complete."
echo "NEXT STEPS:"
echo "1. Restart Termux."
echo "2. Type 'ubuntu' to enter the environment."
echo "3. Run 'bash user.sh' to set up your user and VNC password."
echo "4. Run 'sudo bash gui.sh' to install the desktop and applications."
echo "5. Use 'vncstart' and 'vncstop' (will be created by gui.sh) to manage the GUI."
