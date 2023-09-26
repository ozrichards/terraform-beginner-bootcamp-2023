# Terraform Beginner Bootcamp 2023


![Architecture diagram](https://github.com/ozrichards/terraform-beginner-bootcamp-2023/assets/43056476/dd101b81-e8f9-40e9-b569-dfd7752ba20a)


## Weekly Journals
- [Week 0 Journal](journal/week0.md)
- [Week 1 Journal](journal/week1.md)

## Extras
- [Github Markdown TOC Generator](https://ecotrust-canada.github.io/markdown-toc/)

## Terraform and Input Variables

### Terraform Cloud Variables

In terraform we can set two kind of variables:
- Enviroment Variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibliy in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_ud="my-user_id"`

### var-file flag

- We can use the var-file to specify an external variable file when running terraform apply, terraform plan, or other Terraform CLI commands. eg. `terraform apply -var-file=myvars.tfvars`

### terraform.tvfars

This is the default file to load in terraform variables in blunk

### auto.tfvars

- auto.tfvars just like terraform.tfvars is used for automatically populating variable values, but they have different purposes and order of precedence. auto.tfvars is a filename that Terraform automatically looks for in the current working directory.

### order of terraform variables

Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

- Environment variables
- The terraform.tfvars file, if present.
- The terraform.tfvars.json file, if present.
- Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
- Any -var and -var-file options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)