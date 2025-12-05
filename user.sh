#!/bin/bash

# Solo-Ubuntu User Setup Script
# To be run inside the Ubuntu environment after initial setup.

# --- 1. Set VNC Password ---
echo "--- 1. Setting up VNC Password ---"
echo "You will be prompted to set a VNC password. This is required to connect via VNC Viewer."
echo "The password must be between 6 and 8 characters."
vncserver :1 -localhost no -geometry 1280x720 -depth 24
vncserver -kill :1

# --- 2. Create VNC Start/Stop Scripts ---
echo "--- 2. Creating VNC control scripts ---"

# vncstart script
cat << EOF > /usr/local/bin/vncstart
#!/bin/bash
vncserver :1 -localhost no -geometry 1280x720 -depth 24
EOF
chmod +x /usr/local/bin/vncstart

# vncstop script
cat << EOF > /usr/local/bin/vncstop
#!/bin/bash
vncserver -kill :1
EOF
chmod +x /usr/local/bin/vncstop

echo "VNC control scripts 'vncstart' and 'vncstop' are now available."
echo "User setup complete. Now run 'sudo gui.sh' to install the desktop and applications."
