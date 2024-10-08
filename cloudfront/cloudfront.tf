variable "env" {}

/* -----------------S3----------------- */

resource "random_id" "this" {
  byte_length = 8
}

resource "aws_s3_bucket" "origin" {
  bucket = "${var.env}-origin-bucket-${random_id.this.hex}"
  tags = {
    Name        = "${var.env}-origin-bucket"
    Environment = "${var.env}"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.origin.id
  versioning_configuration {
    status = "Enabled"
  }
}

output "s3" {
  value = aws_s3_bucket.origin.id
}

resource "aws_s3_bucket_website_configuration" "main" {
  bucket = aws_s3_bucket.origin.id
  index_document {
    suffix = "index.html"
  }
}

/* -----------------CloudFront----------------- */

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "main" {
  origin {
    domain_name              = aws_s3_bucket.origin.bucket_regional_domain_name
    origin_id                = "oac-${aws_s3_bucket.origin.bucket_domain_name}"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  price_class = "PriceClass_100"
  enabled     = true

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    viewer_protocol_policy = "redirect-to-https"
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = "oac-${aws_s3_bucket.origin.bucket_domain_name}"
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  tags = {
    Name        = "${var.env}-s3-${aws_cloudfront_origin_access_control.oac.name}"
    Environment = "${var.env}"
  }
}
