# IaC-webapp
IaC-webapp

## Usage
1. Create a manager node using https://github.com/microservices-today/IaC-manager
1. Create a platform dcos cluster using https://github.com/microservices-today/IaC-platform
1. Fork this repository inside the manager node
1. Create a jenkins service. Use this as a template
1. Copy the jenkins files and tar it then upload to s3 bucket
1. Create an acm_certificate_arn manually
1. Buy a route53 domain or transfer if it to aws route53 if you already have it
1. cp terraform.dummy terraform.tfvars
1. update the values (use cdn_boolean=1 if you want to use cloudfront cdn)

#### s3 bucket
Creates an s3 bucket for react/angular build with Static web hosting over index.html

#### route53 record pointing to s3
Adds A route 53 record (alias) using combination of pre_tag and route53_domain_name
#### AWS cloudfront which serves s3 with custom cname in route53.
#### Deploying Jenkins in DCOS.
