# Terraform Ansible 101 

This project is a Terraform and Ansible tutorial.

## Pre-requisites
1. Signup for an AWS Account
2. Install [Terraform](https://www.terraform.io/downloads.html)
3. Install [Ansible](http://docs.ansible.com/ansible/latest/intro_installation.html)

## Steps to Setup Terraform
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
