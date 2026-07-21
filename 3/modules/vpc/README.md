#VPC Module 
Create a VPC with public and private subnets, Internet Gateway , and route tables.

## Usage
```hcl 
  module "vpc" {  
    source = "./modules/vpc"
    vpc_name = "my-vpc"
    vpc_cidr = "10.0.0.0/16"
    environment = "dev"
    tags = {
        Project = "terraform-course"
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
------
|
-------------
|
------
|
---------
|
|
vpc_name
|
Name of vpc
|
string
|
"main-vpc"
|
CIDR block for vpc
|
string 
|
"10.0.0.0/16"
|
|
enable_dns_hostnames
|
Enable DNS hostnames
|
bool
| 
true
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
Descriptions
|
|
-----
|
-------------
|
|
vpc_id
|
VPC ID
|
|
vpc_cidr
|
VPC CIDR block
|
|
public_subnet_ids
|
List of public subnet IDs
|
|
private_subnet_ids
|
List of private subnet IDs
|
|
internet_gateway_id
|
Internet Gateway ID
|

## What this Module Creates
- 1 VPC with specified CIDR
- 2 public subnets (one per AZ)
- 2 private subnets (one per AZ)
- 1 Internet Gateway
- 1 public route table with route to IGW 
- Route associations for public subnets 