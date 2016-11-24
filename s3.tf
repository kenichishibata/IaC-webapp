
data "template_file" "bucket_policy" {
  template = "${file("${path.module}/policy.json")}"
  vars {
    bucket = "${var.pre_tag}.s3.${var.route53_domain_name}"
  }
}

resource "aws_s3_bucket" "website_bucket" {
  bucket = "${var.pre_tag}.s3.${var.route53_domain_name}"
  policy = "${data.template_file.bucket_policy.rendered}"
  acl = "public-read"
  website {
    index_document = "index.html"
    error_document = "404.html"
  }

  tags {
    Name = "${var.pre_tag}-${var.aws_s3_bucket_name}"
    Environment = "${var.env_tag}"
  }

  force_destroy=true
}
