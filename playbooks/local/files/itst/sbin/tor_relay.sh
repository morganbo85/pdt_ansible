#!/bin/bash

# Function to display error messages
function error_exit {
    echo "$1" 1>&2
    exit 1
}

# Update repositories and install required packages
echo "Updating repositories..."
apt update || error_exit "Failed to update repositories."

echo "Installing unattended upgrades and listchanges..."
apt-get install -y unattended-upgrades apt-listchanges || error_exit "Failed to install unattended upgrades."

# Configure Unattended Upgrades
echo "Configuring unattended upgrades..."

cat <<EOF > /etc/apt/apt.conf.d/50unattended-upgrades
Unattended-Upgrade::Allowed-Origins {
  "\${distro_id}:\${distro_codename}-security";
  "TorProject:\${distro_codename}";
};
Unattended-Upgrade::Package-Blacklist {
};
Unattended-Upgrade::Automatic-Reboot "true";
EOF

cat <<EOF > /etc/apt/apt.conf.d/20auto-upgrades
APT::Periodic::Update-Package-List "1";
APT::Periodic::AutocleanInterval "5";
APT::Periodic::Unattended-Upgrade "1";
APT::Periodic::Verbose "1";
EOF

echo "Testing unattended upgrades..."
unattended-upgrade --debug || error_exit "Unattended upgrade test failed."

# Install prerequisites for Tor
echo "Installing prerequisites for Tor..."
apt install -y apt-transport-https || error_exit "Failed to install apt-transport-https."

# Detect Debian version
DEBIAN_VERSION=$(lsb_release -c | awk '{print $2}')
echo "Detected Debian version: $DEBIAN_VERSION"

# Create new sources list file for Tor
echo "Adding Tor repositories..."
cat <<EOF > /etc/apt/sources.list.d/tor.list
deb [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org $DEBIAN_VERSION main
deb-src [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org $DEBIAN_VERSION main
EOF

# Add GPG key for Tor
echo "Adding GPG key for Tor..."
wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | \
    gpg --dearmor | tee /usr/share/keyrings/tor-archive-keyring.gpg >/dev/null || error_exit "Failed to add GPG key."

# Update and install Tor
echo "Updating repositories and installing Tor..."
apt update && apt upgrade -y || error_exit "Failed to update or upgrade packages."
apt install -y tor deb.torproject.org-keyring || error_exit "Failed to install Tor."

# Configure Tor
echo "Configuring Tor..."
cat <<EOF > /etc/tor/torrc
## BASE CONFIG
Nickname TorNode
ContactInfo torr45405@gmail.com
ORPort 443
ExitRelay 0
SocksPort 0

## BANDWIDTH
AccountingMax 800 GB
AccountingStart month 1 0:00

## MONITORING
ControlPort 9051
CookieAuthentication 1
EOF

# Enable and restart Tor
echo "Enabling and restarting Tor..."
systemctl enable tor || error_exit "Failed to enable Tor."
systemctl restart tor || error_exit "Failed to restart Tor."

# Install Nyx monitoring tool
echo "Installing Nyx monitoring tool..."
apt install -y nyx || error_exit "Failed to install Nyx."

echo "Setup complete. You can run Nyx with the 'nyx' command."
