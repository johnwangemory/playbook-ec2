# playbook-ec2

This is a role-based Ansible Playbook to provision EC2 instances with list and terminate plays. All the roles are idempotent which means it is safe to run them multiple times. Currenly, it supports Ubuntu and CentOS only. Two web applications, idservice and mbservice, have been fully tested with Nginx and Apache. Within these web applications, roles for Nginx, Apache2, Tomcat7, ActiveMQ and Postgresql are used.

This playbook treats the EC2 instance immutable on most of the EC2 properties, such as Region, AMI, Type, VPC, Subnet, Volume, etc. It means if any of them needs to be changed, a new instance has to be created with the old instance destroyed. But for other server configurations, such as packages, applications, etc, they will be treated as mutable.

This playbook also requires access to AWS S3 service for artifacts such as qblite-1.0.1.tgzi for QBroker, install.bin for SonicMQ and esblib-1.0.0.tgz for ESB. Therefore, it is assumed that the artifacts have been already uploaded to an S3 bucket and a role to access S3 is already set up for the user account. By default, the role of S3GetRole is assigned to the EC2 instance at the creation. Make sure to overwrite the name of the role via iam_role if it has a different name. You may also overwrite the variables such as qbroker_repo_url in case they are different from the default values.

## Status

Tested with images of Ubuntu 16.04 and CentOS 7 only

## Description

To run the playbook to provision an EC2 instance of Ubuntu 16.04 LTS on the default AWS profile and with the default web application plus the database of Postgresql and the web frontend of Nginx:
```
ansible-playbook -i hosts -e pem_file=~/.ssh/your.pem -e key_name=your_keyname provision.yml
```
where your.pem is the pem file for your private key, your_keyname the name of the keypair. Make sure to replace them with the right ones for you.

To run the playbook to provision an EC2 instance of Ubuntu 16.04 LTS with the default web application plus the database of MySQL and the web frontend of Apache:
```
ansible-playbook -i hosts -e pem_file=~/.ssh/your.pem -e key_name=your_keyname -e web_frontend=apache provision.yml
```

To run the playbook to provision an EC2 instance of Ubuntu 16.04 LTS with the web application of mbservice and the web frontend of Nginx:
```
ansible-playbook -i hosts -e pem_file=~/.ssh/your.pem -e key_name=your_keyname -e wrapper_role=mbservice provision.yml
```

To terminate the launched instances in a specific region, such as us-east-1:
```
ansible-playbook -i hosts -e key_name=your_keyname -e region=us-east-1 terminate.yml
```

To list the launched instances on a specific profile, say the profile of integration:
```
ansible-playbook -i hosts -e pem_file=~/.ssh/your.pem -e key_name=your_keyname -e profile=integration list.yml
```

To run the playbook to provision an EC2 instance of CentOS 7 with the default web application and the web frontend of Nginx:
```
ansible-playbook -i hosts -e pem_file=~/.ssh/your.pem -e key_name=your_keyname -e image_id=ami-9cbf9bf9 provision.yml
```

To run the playbook to provision an EC2 instance of Ubuntu 16.04 LTS with the default web application in a different region:
```
ansible-playbook -i hosts -e pem_file=~/.ssh/your.pem -e key_name=your_keyname -e region=us-east-1 -e vpc_id=vpc-db3fdda2 -e subnet_id=subnet-af7351ca -e image_id=ami-cd0f5cb6 provision.yml
```

In order to run this playbook, the path of the ssh private key file for the key_name has to be specified in the command line under the var name of pem_file. The correct name for the keypair should be specified for key_name. It is also assumed that ~/.aws/credentials is set up with the access_key and secret_key for either the default profile or a specific profile. Further more, it is also assuemd that the ssh key pair has been set up on the AWS region. The default values of the following variables may need to be customized to fit your choice:

| Name                         | Value                | Description                    | File                                 |
| ---                          | ---                  | ---                            | ---                                  |
| key_name                     | ylu                  | name of your ssh key on AWS    | roles/ec2_launcher/defaults/main.yml |
| sg_name                      | {{key_name}}_sg      | name of the security group     | undefined                            |
| instance_tag                 | {{key_name}}_test    | tag name for your EC2 instance | undefined                            |
| instance_type                | t2.micro             | type of EC2 instance           | roles/ec2_launcher/defaults/main.yml |
| image_id                     | ami-8b92b4ee         | AMI id for your OS platform    | roles/ec2_launcher/defaults/main.yml |
| profile                      | default              | AWS profile name               | roles/ec2_launcher/defaults/main.yml |
| region                       | us-east-2            | EC2 region of AWS              | roles/ec2_launcher/defaults/main.yml |
| vpc_id                       | vpc-e8c95f81         | id of an existing VPC          | roles/ec2_launcher/defaults/main.yml |
| subnect_id                   | subnet-5e7cd125      | id of a Subnet on the VPC      | roles/ec2_launcher/defaults/main.yml |
| iam_role                     | S3GetRole            | IAM Role for the instance      | roles/ec2_launcher/defaults/main.yml |
| default_user                 | ec2-user             | default user for ssh           | roles/ec2_launcher/defaults/main.yml |
| pause_for_up                 | 15                   | seconds to pause for vm up     | roles/ec2_launcher/defaults/main.yml |
| sg_rules                     | ...                  | list of rules of security group| roles/ec2_launcher/defaults/main.yml |
| extra_sg_rules               | ...                  | list of extra rules of sgroup  | roles/ec2_launcher/defaults/main.yml |
| wrapper_role                 | idservice            | name of the wrapper role       | provision.yml                        |
| web_frontend                 | nginx                | name of the web frontend       | roles/??service/default/main.yml     |
| qbroker_repo_url             | s3://ylutest/qbroker | repo url for qbroker tarball   | roles/qbroker/defaults/main.yml      |
| sonicmq_repo_url             | s3://ylutest/sonicmq | repo url for sonicmq tarball   | roles/sonicmq/defaults/main.yml      |
| esb_repo_url                 | s3://ylutest/esb     | repo url for esbservice tarball| roles/esbservice/defaults/main.yml   |

The playbook also requires boto and boto3 installed.

## Author
Yannan Lu <yannanlu@yahoo.com>

## See Also
* [Ansible Docs] (http://docs.ansible.com)
* [CentOS EC2 AMI List] (https://wiki.centos.org/Cloud/AWS)
* [Ubuntu EC2 AMI Finder] (https://cloud-images.ubuntu.com/locator/ec2/)
