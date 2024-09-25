ansible all -i home -m ping
ansible all -i home -m apt -a upgrade=dist --become --ask-become-pass
ansible all -i online_svrs -m command -a uptime
ansible-playbook -i inventory/online_svrs playbooks/passwd.yml --extra-vars newpassword=CamNewPass55
