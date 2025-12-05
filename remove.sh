#!/bin/bash

# Solo-Ubuntu Removal Script
# Removes the Ubuntu environment and all associated files from Termux.

echo "--- Solo-Ubuntu Removal Script ---"

# --- 1. Stop VNC Server if running ---
echo "Stopping VNC server..."
vncserver -kill :1 2>/dev/null

# --- 2. Remove Ubuntu Distro ---
echo "Removing Ubuntu proot-distro environment..."
proot-distro remove ubuntu

# --- 3. Remove Scripts and Aliases ---
echo "Removing Solo-Ubuntu scripts and aliases..."
rm -f "$PREFIX/bin/ubuntu"
rm -f "$PREFIX/bin/vncstart"
rm -f "$PREFIX/bin/vncstop"
rm -f user.sh gui.sh

echo "Solo-Ubuntu has been completely removed."
echo "You may also want to manually remove the Solo-Ubuntu repository directory."
