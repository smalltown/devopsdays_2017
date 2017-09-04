# Terraform

This folder illustrate how to create AWS VPC and a simple web server with auto-scaling from scratch

## Folder Structure

There are mainly three foler: 

	terraform-repo/
	├── README.md
	├── aws_account
	│   └── demo
	├── modules
	│   ├── lamp
	│   └── network
	└── operations
   		├── makefiles
   		└── scripts

- aws_account: Store the AWS resource want to create
- modules: the commom module for reusing
- operations: the common makefile, shell script for reusing




## Operation Command

- **Don't forgot to swicth folder where terraform define cloud resource**

	```
	~$ cd ~/terraform-repo/aws_account/demo/us-east-1/Infrastructure_As_Code
	```

- Check the AWS cloud resource will be create/modify

	```
	~$ make plan
	```
- Create the AWS cloud resource

	```
	~$ make apply
	```
	
- Test the created AWS resource

	```
	~$ make test
	```