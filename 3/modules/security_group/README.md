# Security Group Module
Creates a security group with configurable ingress rules for SSH, HTTP, and HTTPS.
## Usage
```hcl
module "security_group"{
    source = "./modules/security_group"
    name = "app-sg"
    description = "Security group for app servers"
    vpc_id = module.vpc.vpc_id
    allow_ssh = true
    allow_http = true
    allow_https = true
    environment = "dev"
    tags = {
        Project = "Terraform-Course"
    }
}
``` 
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
`````````````
|
```````````````
|
```````
|
|
name
|
Security group name
|
string
|
 -
|
|
description
|
Security group description
|
string
|
"Security group"
|
|
vpc_id
|
VPC ID
| 
string
|
-
|
|
allow_ssh
|
Allow SSH access (port 22)
|
bool
| 
true
|
|
allow_http
|
Allow HTTP access (port 80)
|
bool
|
true
|
|
allow_https
|
Allow HTTPS access (port 443)
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
Description
|
|
````````````
|
|
id
|
Security group ID
|
|
name
|
Security group name
|

## What This Module Creates

- 1 security group 
- Ingress rule (SSH, HTTP, HTTPS) - controlled by variables
- Egress rule (allow all outbound traffic)
- Tags for organization and identification 

## Example with Different Ingress Rules

```hcl 
module "web_sg" {
    source = "./modules/security_group"
    name = "web-sg"
    vpc_id = module.vpc.vpc_id
    allow_ssh = false
    allow_http = true
    allow_https = true
}
```

