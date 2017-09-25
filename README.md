# Terraform Ansible 101 

In this project, we will provision a server using Terraform.  After the server is provisioned, we will configure the server by installing Docker in it.  We will use Ansible to install Docker in the server.

## What is Terraform?
* Tool created by Hashicorp
* Infrastructure as Code
* Build server and network infrastructure
* Configuration files that describe the state of the components in your infrastructure
* Declarative style when writing code

## Common commands you will use in Terraform
* terraform init
* terraform plan
* terraform apply
* terraform destroy

## What is Ansible?
* Tool created by Redhat
* Simple IT automation engine
* Configuration management tool
* Agentless
* Requires SSH access to the target server
* Requires Python to be installed in the target server
* Procedural style when writing code

## Other automation tools
* Puppet
* Chef
* CFEngine
* Vagrant
* SaltStack
* CloudFormation

## Pre-requisites
1. Signup for an AWS Account
2. Install [Terraform](https://www.terraform.io/downloads.html)
3. Install [Ansible](http://docs.ansible.com/ansible/latest/intro_installation.html)

## Steps to Provision Servers
1. Install terraform
2. Add your AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY in your environment variables.
```
export AWS_ACCESS_KEY_ID="aws_access_key"
export AWS_SECRET_ACCESS_KEY="aws_secret_key"
```
3. Go to `provision` folder.
4. Create an SSH key pair using "dev_key" as the name. 
```
$ ssh-keygen -q -f dev_key -C aws_terraform_ssh_key -N ''
```
5. Run `$ terraform init` to get the provider.  In this case, it is AWS.
6. Run `terraform plan` to see what Terraform is going to be applied in your AWS environment. 
7. Run `terraform apply`.


## Steps to Configure Servers
1. Install Ansible
2. Go to `configure` folder
3. Get the IP of the target server and create `inventory` file
4. Run the Ansible playbook `$ ansible-playbook -i inventory docker.yml`