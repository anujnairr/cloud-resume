
data "aws_iam_policy_document" "oac-policy" {

  statement {

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = ["s3:GetObject"]

    resources = ["${aws_s3_bucket.origin.arn}/*"]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.main.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "oac-policy" {
  bucket = aws_s3_bucket.origin.id
  policy = data.aws_iam_policy_document.oac-policy.json
}
