resource "aws_route53_record" "s3_record" {
  zone_id = "${var.hosted_zone_id}"
  name = "${var.pre_tag}.${var.route53_domain_name}"
  type = "A"

  alias {
    name = "${aws_s3_bucket.website_bucket.website_domain}"
    zone_id = "${aws_s3_bucket.website_bucket.hosted_zone_id}"
    evaluate_target_health = false
  }
}
resource "aws_route53_record" "cdn_record" {
  zone_id = "${var.hosted_zone_id}"
  name = "${var.pre_tag}-webapp-cdn.${var.route53_domain_name}"
  type = "A"
  count = "${var.cdn_boolean}"

  alias {
    name = "${lower(aws_cloudfront_distribution.s3_distribution.hosted_zone_id)}"
    zone_id = "${aws_cloudfront_distribution.s3_distribution.hosted_zone_id}"
    evaluate_target_health = false
  }
}