output "cf-arn" {
  value = aws_cloudfront_distribution.main.arn
}

output "s3" {
  value = aws_s3_bucket.origin.id
}

output "s3-arn" {
  value = aws_s3_bucket.origin.arn
}
