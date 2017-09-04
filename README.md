# DevOpsDays Taipei 2017 - Everything As Code
This repository is for demonstrate below items:

- Jenkins: Pipeline As Code
- Terraform: Infrastructure As Code
- <del>CM: Provision As Code</del>
- <del>Packer: Image As Code</del>
- <del>Docker: Server As Code</del>
- <del>Kubernetes: Orchestration As Code</del>
- <del>Hubot: Chat As Code</del>

If anyone is interested about the ignore topic above, here is the [**Slide**](https://www.slideshare.net/smalltown20110306/coscup-2017-infrastructure-as-code) and [**GitHub Repository**](https://github.com/smalltown/coscup_2017) for reference ^^

# There are three modules need to be setup...

## Prerequisite

- Linux Based Machine
- Docker
- AWS Account

## Jenkins (power by container)

- Export AWS access key ID, secret access key and region

	```
	~$ export AWS_ACCESS_KEY_ID =XXXXXX
	~$ export AWS_SECRET_ACCESS_KEY =XXXXXX
	~$ export AWS_DEFAULT_REGION=us-east-1
	```

- Create a AWS S3 bucket as Terraform as backend to store cloud resource state, then export the S3 bucket name

	```
	~$ export TERRAFORM_BACKEND_S3_BUCKET=${S3 Bucket Name}

	```

- Execute below command to launch Jenkins

	```
	~$ ./jenkins.container

	Pull the image: smalltown/devopsdays_2017:jenkins
	jenkins: Pulling from smalltown/devopsdays_2017
	06b22ddb1913: Already exists
	
	...
	
	Digest: sha256:3e8e2c1e3dac5d0df8f767c2f73bbbdfbf5872f528efb3ae2c0955e0534da9cf
	Status: Downloaded newer image for smalltown/	devopsdays_2017:jenkins

	Starting Docker Container: smalltown/devopsdays_2017:jenkins:
	Container ID: jenkins-1504540691
	AWS Default Region: us-east-1
	AWS Access Key ID: ********
	AWS Secret Access Key: ********
	Terraform Backend S3 Bucket: ${S3 Bucket Name}
	e682b9b8ba03d66cd7de01c51446627871a1f860b19ce33984f7a24090ab1854
	```

- Visit http://127.0.0.1 from the browser after several minutes

- Login Jenkins by below account and password<br/>
	- Admin Account  : devopsdays<br/>
	- Admin Password : devopsdays

## Terraform (power by Hashicorp)

- Get the Jenkins container ID, e.g. here is e682b9b8ba03

	```
	~$ docker ps

	CONTAINER ID        IMAGE                               COMMAND                  CREATED             STATUS              PORTS                                            NAMES
	e682b9b8ba03        smalltown/devopsdays_2017:jenkins   "/bin/tini -- /usr..."   10 minutes ago      Up 10 minutes       0.0.0.0:50000->50000/tcp, 0.0.0.0:80->8080/tcp   jenkins-1504540691
	```

- Enter the container

	```
	~$ docker exec -it e682b9b8ba03 bash
	```
	
- Switch to the Terraform repository folder

	```
	~$ cd ~/terraform-repo/aws_account/demo/us-east-1/Infrastructure_As_Code
	```

- Refer to [**The Document**](./jenkins_home/terraform-repo/README.md) for terraform operation