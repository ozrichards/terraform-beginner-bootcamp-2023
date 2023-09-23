# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)

The general format:

 **MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI installation instructions have changed due to gpg keyring changes. So we needed refer to the latest install CLI instructions via Terraform Documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution

This project is built against Ubuntu.
Please consider checking your Linux Distribution and change accordingly to distribution needs.

[How To Check OS Version in Linux](https://linuxize.com/post/how-to-check-linux-version/)

Example of checking os version
```
$ cat /etc/os-release 
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```
### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg depreciation issues, we noticed that the bash scripts steps were a considerable amount more code. So we decided to create a bash script to install the Terrafrom CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This allows us an easier way to debug and execute manually Terrafrom CLI install.
- This will allow better portability for other projects that need to install Terraform CLI.

## Execution Considerations

When exceuting the bash script we can use the './' shorthand notation to execute the bash script.

eg. `./bin/install_terrafrom_cli`

If we are using a script in .gitpod.yml we need to point the script to a program to interpret it.

eg. `source ./bin/install_terraform_cli`

## Linux Permissions Considerations

In order to make our bash scripts executable we need a change to the linux permission for the fix to be executable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```
alternatively:

```sh
chmod 744
```

### Github Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks


### Working With Env Vars

#### env coomand

We can list out all Environment Variables using the `env` command in the terminal.

We can filter specific env vars using grep eg. `env | grep AWS_`

#### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='world'`

In the terminal we unset using  `unset HELLO`

We can set an env var temporarily when  just running a command

```sh
HELLO= 'world' ./bin/print_messgae
```

Within a bash script we can set env without writing export eg.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

## Printing env vars

We can print an env var using echo eg. `echo $HELLO`

#### Scoping of Env Vars

When you open new bash terminals in VSCode it will not be aware of env vars that you have set in another window.

If you want to have Env Vars to persist across all future bash terminals that are open you need to set env vars in your bash profile. eg. `.bash_profile`


#### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world'
```

All future workspaces launch will set the env vars for all bash terminals opened in those workspaces.

You can also set env vars in th env vars in the `.gitpod.yml` but this can only contain non-sensitive env vars.


### AWS CLI Installation

AWS CLI is installed for this project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)


[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials is configured correctly by running the following AWS CLI command:
```sh
aws sts get-caller-identity
```

If it is successful you should see a json payload return that looks like this;

```json
{
    "UserId": "AKIAIOSFODNN7EXAMPLE",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```

We'll need to generate AWS CLI credentials from IAM User in order to use the aws cli.

Example credentials from the docs
```
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_DEFAULT_REGION=us-west-2 
```

## Terraform Basics

### Terraform Registry

Terraform sources thier providers and modules from the Terraform registry which located at [https://registry.terraform.io/](https://registry.terraform.io/)

- **Providers** is an interface to APIs that will allow you to create resources in terraform
- **Modules** are a way to make large amount of terrform code modular,portable and sharable.

### Terrafrom Console

We can see a list of all the Terraform commands by simply typing `terrafrom`

#### Terraform Init

At the start of a new terrafrom project we will run `terrafrom init` to download the binaries for the terraform providers that we'll use in this project.

#### Terrafrom Plan

This will generate out a changeset, about the state of our infrastructure and what will be changed.

We can outpyt this changeset ie. "plan" to be passed to an apply, but often you can just ignore outputting.


##### Terrafrom Apply

`terraform apply`

This will run a plan and pass the changeset to be excuted by terraform. Apply should prompt yes or no.

If we want to automatically approve an apply we can provide the auto approve flag eg. `terraform apply --auto-approve`

#### Terraform Destroy

`terraform destroy`

This will destroy resources

You can also use the auto approve flag to skip the approve prompt eg. `terraform apply --auto-approve`

## Terrafrom Lock Files

`.terraform.lock.hcl` conatins the locked versioning for the providers or modules thay should be used with this project.

The Terraform Lock File shoul dbe committed to your Version Control Sytem (VSC) eg. Github

### Terrafrom State Files

`.terrafrom.tfstate` contain information about the current state of your infrastructure.

This file **should not be committed** to your VCS.

this file can contain sensitive data.

If you lose this file, you lose knowing the state of your infrastructure.

`.terraform.tfstate.backup` is the prevopus file state.

### Terrafrom Directory

`.terraform` directory contains binaries of terraform providers.

## Isues with Terrafrom Cloud Login and Gitpod Workspace

When attempting to run `terraform login` it will launch bash a wiswig view to generate a token. However it does not work expected in Gitpod Vscode in the browser.

The workaround is manually generate a token in Terraform Cloud



[User API Tokens](https://developer.hashicorp.com/terraform/cloud-docs/users-teams-organizations/users#api-tokens)

Then create the file manually here:

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the following code (replace your token in the file):

```json
{
    "credentials": {
      "app.terraform.io": {
        "token":"YOUR-TERRAFORM-CLOUD-TOKEN"
       
      }
    }
  }
```

