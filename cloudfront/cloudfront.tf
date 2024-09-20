module "origin" {
  source = "../s3"
  env    = var.env
}

variable "env" {}

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "main" {
  origin {
    domain_name              = module.origin.bucket_domain_name
    origin_id                = "oac-${module.origin.bucket}" /*"oac-${aws_s3_bucket.}"*/
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  enabled = true
  viewer_certificate {
    cloudfront_default_certificate = true
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["IN"]
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    viewer_protocol_policy = "redirect-to-https"
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "oac-${module.origin.bucket_domain_name}" /*"oac-${aws_s3_bucket.origin.bucket}" */
  }

  tags = {
    Name        = "${var.env}-s3-${aws_cloudfront_origin_access_control.oac.name}"
    Environment = "${var.env}"
  }
}
