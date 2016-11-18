resource "aws_cloudfront_distribution" "website_cdn" {
  enabled = true
  price_class = "PriceClass_200"
  http_version = "http1.1"

  "origin" {
    origin_id = "origin-bucket-${aws_s3_bucket.website_bucket.id}"
    domain_name = "${aws_s3_bucket.website_bucket.website_endpoint}"
    custom_origin_config {
      origin_protocol_policy = "http-only"
      http_port = "80"
      https_port = "443"
      origin_ssl_protocols = ["TLSv1"]
    }
    # custom_header {
    #   name = "User-Agent"
    #   value = "${var.duplicate-content-penalty-secret}"
    # }
  }
  default_root_object = "index.html"
  # custom_error_response {
  #   error_code = "404"
  #   error_caching_min_ttl = "360"
  #   response_code = "200"
  #   response_page_path = "${var.not-found-response-path}"
  # }
  "default_cache_behavior" {
    allowed_methods = ["GET", "HEAD", "DELETE", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods = ["GET", "HEAD"]
    "forwarded_values" {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    min_ttl = "0"
    default_ttl = "300" //3600
    max_ttl = "1200" //86400
    target_origin_id = "origin-bucket-${aws_s3_bucket.website_bucket.id}"
    # // This redirects any HTTP request to HTTPS. Security first!
    viewer_protocol_policy = "allow-all"
    # compress = true
  }
  "restrictions" {
    "geo_restriction" {
      restriction_type = "none"
    }
  }
  # "viewer_certificate" {
  #   acm_certificate_arn = "${var.acm-certificate-arn}"
  #   ssl_support_method = "sni-only"
  #   minimum_protocol_version = "TLSv1"
  # }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
  # aliases = ["${var.domain}"]
}