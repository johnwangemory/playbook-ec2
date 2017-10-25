# playbook-ec2

This is an Ansible Playbook to provision EC2 instances with list and terminate plays. All the playbooks are idempotent which means it is safe to run them multiple times. Currenly, it supports Ubuntu and CentOS only. Two web applications, idservice and mbservice, have been fully tested with Nginx and Apache. Within these web applications, roles for Nginx, Apache2, Tomcat7, ActiveMQ and Postgresql are used.

This playbook treats the EC2 instance immutable on most of the EC2 properties, such as AMI, Type, VPC, Networks, Volume, etc. It means if any of them needs to be changed, a new instance has to be created with the old instance destroyed. But for other server configurations, such as packages, applications, etc, they will be treated as mutable.

## Status

Tested with images of Ubuntu and CentOS only

## Description

To run the playbook to provision an EC2 instance of Ubuntu 16.04 LTS with the default web application plus the database of Postgresql and the web frontend of Nginx:
```
ansible-playbook -i hosts -e pem_file=~/.ssh/ylu.pem provision.yml
```

To run the playbook to provision an EC2 instance of Ubuntu 16.04 LTS with the default web application plus the database of MySQL and the web frontend of Apache:
```
ansible-playbook -i hosts -e pem_file=~/.ssh/ylu.pem apache.yml
```

To run the playbook to provision an EC2 instance of Ubuntu 16.04 LTS with the web application of mbservice and the web frontend of Nginx:
```
ansible-playbook -i hosts -e pem_file=~/.ssh/ylu.pem -e myrole=mbservice provision.yml
```

To terminate the launched instances:
```
ansible-playbook -i hosts terminate.yml
```

To list the launched instances:
```
ansible-playbook -i hosts list.yml
```

To run the playbook to provision an EC2 instance of CentOS 7 with the default web application and the web frontend of Nginx:
```
ansible-playbook -i hosts -e pem_file=~/.ssh/ylu.pem -e image_id=ami-9cbf9bf9 provision.yml
```

To run the playbook to provision an EC2 instance of Ubuntu 16.04 LTS with the default web application in a different region:
```
ansible-playbook -i hosts -e pem_file=~/.ssh/ylu.pem -e aws_region=us-east-1 -e vpc_id=vpc-db3fdda2 -e subnet_id=subnet-af7351ca -e image_id=ami-cd0f5cb6 provision.yml
```

In order to run this playbook, the path of the ssh private key file for the key_name has to be specified in the command line under the var name of pem_file. It is also assumed that ~/.aws/credentials is set up with the access_key and secret_key. Further more, it is also assuemd that the ssh key pair has been set up on the AWS region. The following default variables will need to be customized to fit your choice:

| Name                         | Value           | Description                    | File                                 |
| ---                          | ---             | ---                            | ---                                  |
| key_name                     | ylu             | name of your ssh key on AWS    | roles/ec2_launcher/defaults/main.yml |
| sg_name                      | ylu_sg          | name of the security group     | roles/ec2_launcher/defaults/main.yml |
| instance_tag                 | ylu_test        | tag name for your EC2 instance | roles/ec2_launcher/defaults/main.yml |
| instance_type                | t2.micro        | type of EC2 instance           | roles/ec2_launcher/defaults/main.yml |
| image_id                     | ami-8b92b4ee    | AMI id for your OS platform    | roles/ec2_launcher/defaults/main.yml |
| aws_region                   | us-east-2       | EC2 region of AWS              | roles/ec2_launcher/defaults/main.yml |
| vpc_id                       | vpc-e8c95f81    | id of an existing VPC          | roles/ec2_launcher/defaults/main.yml |
| subnect_id                   | subnet-5e7cd125 | id of a Subnet on the VPC      | roles/ec2_launcher/defaults/main.yml |
| default_user                 | ec2-user        | default user for ssh           | roles/ec2_launcher/defaults/main.yml |
| pause_for_up                 | 15              | seconds to pause for vm up     | roles/ec2_launcher/defaults/main.yml |
| sg_rules                     | ...             | list of rules of security group| roles/ec2_launcher/defaults/main.yml |
| extra_sg_rules               | ...             | extra rules of security group  | roles/activemq/defaults/main.yml     |

The playbook also requires boto and boto3 installed.

## Author
Yannan Lu <yannanlu@yahoo.com>

## See Also
* [Ansible Docs] (http://docs.ansible.com)
* [CentOS EC2 AMI List] (https://wiki.centos.org/Cloud/AWS)
* [Ubuntu EC2 AMI Finder] (https://cloud-images.ubuntu.com/locator/ec2/)
