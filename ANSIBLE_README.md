ansible all -i home -m ping
ansible all -i home -m apt -a upgrade=dist --become --ask-become-pass
ansible all -i online_svrs -m command -a uptime
ansible-playbook -i inventory/online_svrs playbooks/passwd.yml --extra-vars newpassword=CamNewPass55
ansible-playbook -i inventory/home playbooks/passwd.yml --extra-vars newpassword='Trudy1985sudo vi test1' --ask-become-pass
ansible-playbook -i inventory/home playbooks/update.yml --ask-become-pass
ansible-playbook -i inventory/online_svrs playbooks/ntfy.yml --ask-become-pass
curl -sSL https://raw.githubusercontent.com/morganbo85/pdt_ansible/main/bootstrap.sh | bash
