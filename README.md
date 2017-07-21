# playbook-ec2

Ansible Playbook for provision EC2 instances with list and terminate plays. All the playbooks are idempotent which means it is safe to run them mutiple times.

## Status

## Description

To run the playbook to provision an EC2 instance:
```
ansible-playbook -i hosts -vvv provision.yml
```

To terminate the launched instances:
```
ansible-playbook -i hosts -vvv terminate.yml
```

To list the launched instances:
```
ansible-playbook -i hosts -vvv list.yml
```

## Author
Yannan Lu <yannanlu@yahoo.com>
