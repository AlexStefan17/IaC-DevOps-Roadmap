# IaC-DevOps-Roadmap
IaC-DevOps-Roadmap
https://roadmap.sh/projects/iac-digitalocean

The goal of this project is to introduce you to the basics of IaC using Terraform. You will create a DigitalOcean Droplet and configure it using Terraform.

This project will create an EC2 ubuntu machine on aws using terraform and with ansible it will configure nginx with a static website.

## Prerequisites
Edit terraform main.tf file:
- ssh key

Edit ansible inventory.yml
- ip
- user
- ssh key

## How to run terraform:

```
terraform init
```

```
terraform apply -auto-approve
```

## How to run ansible:

### How to run all roles
```bash
ansible-playbook -i inventory.yml setup.yml
```
### How to run specific roles:
```
ansible-playbook -i inventory.yml setup.yml --tags "app,nginx"
```