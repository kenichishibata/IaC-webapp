resource "aws_route53_record" "s3_record" {
  zone_id = "${var.hosted_zone_id}"
  name = "${var.pre_tag}.s3.${var.route53_domain_name}"
  type = "A"

  alias {
    name = "${aws_s3_bucket.website_bucket.website_domain}"
    zone_id = "${aws_s3_bucket.website_bucket.hosted_zone_id}"
    evaluate_target_health = false
  }
}


resource "aws_route53_record" "https_record" {
	count = "${var.cdn_boolean}"

	depends_on = ["aws_cloudfront_distribution.s3_distribution"]
	zone_id = "${var.hosted_zone_id}"
	name = "${var.pre_tag}.${var.route53_domain_name}"
	type = "A"

	alias {
		name = "${aws_cloudfront_distribution.s3_distribution.domain_name}"
		zone_id = "${aws_cloudfront_distribution.s3_distribution.hosted_zone_id}"
		evaluate_target_health = false
	}
}

resource "aws_route53_record" "cname_jenkins" {
	count = "${var.cdn_boolean}"

	depends_on = ["null_resource.jenkins-dcos-installation"]
	zone_id = "${var.hosted_zone_id}"
	name = "${var.pre_tag}-jenkins.${var.route53_domain_name}"
	type = "CNAME"
	ttl = "300"
	records = ["${aws_cloudfront_distribution.jenkins_distribution.domain_name}"]

}
