provider "aws" {
    alias = "tokyo"
    region = "ap-northeast-1"
}

resource "aws_s3_bucket" "website_bucket" {
    # provider = "aws.${var.region}"
    provider = "aws.tokyo"
    bucket = "${var.aws_s3_bucket_name}"
    acl = "public-read"
    policy = "${data.template_file.bucket_policy.rendered}"
    force_destroy = true

    tags {
        Name = "${var.aws_s3_bucket_name}"
        Environment = "${var.aws_s3_environment}"
    }

    website {
        index_document = "index.html"
        error_document = "error.html"
    }
}

data "template_file" "bucket_policy" {
  template = "${file("${path.module}/policy.json")}"
  vars {
    bucket = "${var.aws_s3_bucket_name}"
  }
}