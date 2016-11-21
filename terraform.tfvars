/* AWS
Provides a S3 bucket resource.
*/
aws_s3_bucket_name="webapp-test"
domain="microservices.today"
acm_certificate_arn="arn:aws:acm:us-east-1:703222074876:certificate/d88a7314-b07d-4a7d-9e36-aaa54af59fb8" #use only cert available in us-east-1
pre_tag = "pre"        /* Pre-tag to be attached to AWS resources for identification */
post_tag = "terra"
env_tag="staging"             /*Environment tag*/
route53_domain_name="test.wearex.com" /* base domain name */
region="ap-northeast-1"