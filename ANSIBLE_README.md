ansible all -i home -m ping
ansible all -i home -m apt -a upgrade=dist --become --ask-become-pass
