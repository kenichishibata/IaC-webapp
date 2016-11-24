output "origin_url" {
  value = "${aws_route53_record.s3_record.fqdn}"
}

output "cdn_url" {
  value = "${aws_route53_record.cname_record.fqdn}"
}

output "s3_bucket_name" {
	value = "${aws_s3_bucket.website_bucket.id}"
}
