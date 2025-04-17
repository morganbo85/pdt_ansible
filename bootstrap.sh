#!/bin/bash
apt update && apt install -y git ansible
git clone https://github.com/morganbo85/pdt_ansible.git /etc/setupmachine
cp /etc/setupmachine/playbooks/local/files/provision.* /etc/systemd/system/
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable --now provision.timer
ansible-pull -o -U https://github.com/morganbo85/pdt_ansible.git
