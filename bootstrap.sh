#!/bin/bash

# Exit immediately if any command fails
set -e

echo "🔧 Installing dependencies..."
apt update && apt install -y git ansible

echo "📥 Cloning repo to /etc/setupmachine"
git clone https://github.com/morganbo85/pdt_ansible.git /etc/setupmachine

echo "⚙️ Copying systemd unit files..."
cp /etc/setupmachine/playbooks/local/files/provision.* /etc/systemd/system/

echo "🔄 Reloading systemd..."
systemctl daemon-reexec
systemctl daemon-reload

echo "⏱️ Enabling systemd timer..."
systemctl enable --now provision.timer

echo "🚀 Triggering initial ansible-pull run..."
ansible-pull -o -U https://github.com/morganbo85/pdt_ansible.git

echo "✅ Setup complete."
