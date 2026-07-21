# EC2 Module

Create an EC2 instance with specified configuration in a VPC and subnet. 

## Usage 

```hcl
module "ec2" {
    source = "./modules/ec2"
    instance_name = "web-server"
    instance_type = "t2.micro"
    subnet_id = module.vpc.public_subnet_ids[0]
    security_group_ids = [module.security_group.id]
    environment = "dev"
    tags = {
        Project = "Terraform-Course"
    }
}
```

## Inputs
|
Name
|
Description
|
Type
| 
Default
|
|
``````
|
``````````
|
``````
|
`````````
|
|
instance_type
|
Ec2 instance type
|
string
|
"t2.micro"
|
|
instance_name
|
Instance name
|
string
|
-
|
|
subnet_id
|
Subnet ID where instance will be placed
|
string
|
- 
|
|
security_group_ids
|
List of security group IDS
|
list(string)
|
-
|
|
environment
|
Environment name
|
string
|
"dev"
|
|
tags
|
Common tags for resources
|
map(string)
|
{}
|

## Outputs
|
Name
|
Description
|
|
`````````
|
```````````
|
|
id
|
Ec2 instance ID
|
|
public_ip
|
Public IP address (if assigned)
|
|
private_ip
|
Private Ip address
|
|
ami_id
|
AMI ID used for the instance
|

## What This Module Creaes 

- 1 EC2 instance
- Uses latest Ubuntu 20.04 LTS AMI (fetched dynamically)
- Placed in specified subnet
- Associated with specified security groups
- User Data script to tag instance creation

## Accessing Instance

```bash 
terraform output instance_public_ip

# SSH into instance (requires keypair)
ssh -i key.pem ubuntu@public_ip
````

## Notes 
- Instance uses lates Ubuntu 20.04 LTS by default
- Public IP assigned if in publi subnet 
- User data script creates /tmp/module-info.txt
- Instance name from tags (Name tag)