#general name for the bucket. Pretag will be added to it.
variable "aws_s3_bucket_name" {
  description = "Name of the aws s3 bucket to which builded codes are deployed"
}
#The aws region
variable "region" {
  description = "Name of the aws s3 bucket region"
}
#Pre tag to append to all resources
variable "pre_tag" {
  description = "Pre Tag for all the resources"
  default = "pre"
}
#Post tag to append to all resources
variable "post_tag" {
  description = "Post Tag for all the resources"
  default = "post"
}
#Environment Tag
variable "env_tag" {
  description = "Name of Environment"
  default = "staging"
}
#Acm certificate for N.virginia Region
variable "acm_certificate_arn" {
  description = "value of the aws certificate arn"
}
#Route53 domain name
variable "route53_domain_name" {
  description = "Route53 Domain Name"
}
#CDN Boolean to avoid CND if not required
variable "cdn_boolean" {
  description = "Install CDN? 1-Yes, 2-No"
  default = 1
}
#CDN Boolean to avoid CND if not required
variable "hosted_zone_id" {
  description = "Route53 hosted Zone ID"
 }
#DCOS URL
variable "dcos_url" {
  description = "DCOS URL"
 }
