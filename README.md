# playbook-ec2

Ansible Playbook to provision EC2 instances with list and terminate plays. All the playbooks are idempotent which means it is safe to run them multiple times.

## Status

## Description

To run the playbook to provision an EC2 instance:
```
ansible-playbook -i hosts provision.yml
```

To terminate the launched instances:
```
ansible-playbook -i hosts terminate.yml
```

To list the launched instances:
```
ansible-playbook -i hosts list.yml
```

In order to run this playbook, it is assumed that ~/.aws/credentials is set up with the access_key and secret_key. Further more, it is also assuemd that the ssh key pair has been set up on the AWS account. The following variables will need to be customized to fit your needs:

| Name                         | Value           | Remark                         | File                             |
| ---                          | ---             | ---                            | ---                              |
| ansible_ssh_private_key_file | ~/.ssh/ylu.pem  | path to your ssh private key   | provision.yml                    |
| key_name                     | ylu             | name of your ssh key on AWS    | roles/ec2_launcher/vars/main.yml |
| sg_name                      | mysg            | name of the security group     | roles/ec2_launcher/vars/main.yml |
| instance_tag                 | yannan2         | tag name for your EC2 instance | roles/ec2_launcher/vars/main.yml |
| aws_region                   | us-east-2       | EC2 region of AWS              | roles/ec2_launcher/vars/main.yml |
| instance_type                | t2.micro        | type of EC2 instance           | roles/ec2_launcher/vars/main.yml |
| image_id                     | ami-618fab04    | AMI of Ubuntu 14.04            | roles/ec2_launcher/vars/main.yml |
| vpc_id                       | vpc-e8c95f81    | id of an existing VPC          | roles/ec2_launcher/vars/main.yml |
| subnect_id                   | subnet-5e7cd125 | id of an existing Subnet       | roles/ec2_launcher/vars/main.yml |

## Author
Yannan Lu <yannanlu@yahoo.com>
