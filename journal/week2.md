# Terraform Beginner Bootcamp 2023 - Week 2

## Working with Ruby

### Bundler

Bundler is a package manager for ruby.
It is the primary way to install ruby packages (known as gems) for ruby.

#### Install Gems

You need to create a Gemfile and define your gems in that file.

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run the `bundle install` command

This will install the gems on the system globally (unlike nodejs which install packages in place in a folder called node_modules)

A Gemfile.lock will be created to lock down the gem versions used in this project.

#### Executing ruby scripts in the context of bundler

We have to use `bundle exec` to tell future ruby scripts to use the gems we installed. This is the way we set context.

### Sinatra

Sinatra is a micro web-framework for ruby to build web-apps.

Its great for mock or development servers or for very simple projects.

You can create a web-server in a single file.

https://sinatrarb.com/

## Terratowns Mock Server

### Running the web server

We can run the web server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```

All of the code for our server is stored in the `server.rb` file.

## CRUD

Terraform Provider resources utilize CRUD.

CRUD stands for Create, Read Update, and Delete

https://en.wikipedia.org/wiki/Create,_read,_update_and_delete

## Other Terraform notes

The The required providers block needs to be specified in a Terraform project to configure a provider.

```go 
go get
``` 
command is for installing missing dependencies in Go.

The purpose of the provider configure function in the discussed Go code is to initialize the provider with configuration details
"Marshal" function in Go is used to convert data into bytes

The Terraform provider primarily cares about the "ID" for mapping.

Schema is used to define the inputs in a Terraform provider

OUTPUTS can be used to reference a specific attribute of a resource in Terraform

The term "interpolation" refers to the process of embedding variables within other strings.

Remote execution mode can be changed to "local" in Terraform Cloud