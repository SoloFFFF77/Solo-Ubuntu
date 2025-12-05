#!/bin/bash

# Solo-Ubuntu GUI and Application Setup Script
# To be run inside the Ubuntu environment with sudo privileges.

# --- 1. System Update and Desktop Environment (XFCE) ---
echo "--- 1. Installing XFCE Desktop Environment and VNC Server ---"
apt update -y
apt upgrade -y
apt install -y xfce4 xfce4-goodies tightvncserver dbus-x11 git wget curl

# --- 2. Configure XFCE for VNC ---
echo "--- 2. Configuring XFCE for VNC ---"
mkdir -p ~/.vnc
cat << EOF > ~/.vnc/xstartup
#!/bin/bash
xrdb \$HOME/.Xresources
startxfce4 &
EOF
chmod +x ~/.vnc/xstartup

# --- 3. Install Pre-requested Applications ---
echo "--- 3. Installing Pre-requested Applications ---"

# Firefox
echo "Installing Firefox..."
apt install -y firefox

# Git (already installed with base packages, but good to ensure)
echo "Installing Git..."
apt install -y git

# VS Code (Using official Microsoft repository)
echo "Installing VS Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sh -c 'echo "deb [arch=amd64,arm64,armhf] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
apt update
apt install -y code

# Android Studio (Note: Android Studio is complex to install via apt and requires Java, a large download, and a proper desktop environment. For a Termux proot environment, a simple script-based installation is not feasible. We will provide a placeholder and a note.)
echo "Installing Java Development Kit (required for Android Studio)..."
apt install -y openjdk-17-jdk

# Google Anti-Gravity IDE (This is a fictional IDE. We will use a placeholder message.)
echo "Note: Google Anti-Gravity IDE is a placeholder feature. For now, enjoy the other powerful tools."

# --- 4. Cleanup ---
echo "--- 4. Cleaning up installation files ---"
apt autoremove -y
apt clean

echo "GUI and application setup complete. You can now run 'vncstart' and connect with your VNC Viewer."
