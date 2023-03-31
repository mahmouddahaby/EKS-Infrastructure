
# Fixed Solutions Infrastructure

Automate deployment of Fixed Solutions Infrastructure using a Jenkins pipeline and Jenkinsfile to deploy infrastructure changes automatically when any change is made in the master branch. This repository is a collection of scripts and tools designed to manage and deploy infrastructure across multiple environments. It includes shell scripts, Terraform configurations, and Dockerfiles, among other tools, which can be used to automate the deployment and configuration of various infrastructure components, such as servers, EKS, and networking components while minimizing costs.





--------------

## Deploy private EKS in VPC can be reached using ec2 within the same VPC



## Tools Used

- AWS
- Terraform
- Docker
- Kubernetes
- Jenkins
- Bash
- Nginx Proxy Server


-------

## Prerequisites
Before you can use this repository, you need to have the following:

1- An AWS account

2- The AWS CLI installed and configured on your local machine

3- Terraform installed on your local machine

4- Linux-based environment, such as Ubuntu or CentOS

----
### How to Use
1- Clone the repository to your local machine.
```
git clone https://github.com/mahmouddahaby/Fixed-Solutions-Infrastructure.git
```

2- Run terraform init to initialize the project.

```
terraform init
```

3- Run terraform plan to review the infrastructure changes that will be made.

```
terraform plan
```

4- If you're satisfied with the plan, run terraform apply to create the infrastructure on AWS.

```
terraform apply -auto-approve
```
If you're satisfied with the plan, run terraform apply to create the infrastructure on AWS.

- After the infrastructure is created, you can log in to the EC2 instance using the key pair you created during the Terraform apply process.
### How to Connect to the App
- Open the AWS Management Console and navigate to the EC2 Dashboard.

- Select the instance you created during the Terraform apply process.

- Click the "Connect" button at the top of the screen.

- Follow the instructions to connect to the instance using the key pair you created during the Terraform apply process.
---
### To connect to Jenkins server running in your eks 

- First get jenkins service

```
kubectl get service -n devops-tools 
```

- Second search for Load Balancer service and use it's ip and port and try it in your browser

---

## Contributing
If you would like to contribute to this repository, please create a pull request with your proposed changes. We welcome contributions of all kinds, including bug fixes, feature enhancements, and new tools and scripts that help optimize costs.
