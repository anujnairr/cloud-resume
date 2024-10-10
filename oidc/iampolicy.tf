
data "aws_iam_policy_document" "oidc-policy" {
  statement {
    sid = "2"
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.this.arn]
    }
    actions   = ["sts:AssumeRoleWithWebIdentity"]
    resources = ["${var.s3-arn}/*"]

    condition {
      test     = "ForAnyValue:StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:anujnairr/cloud-resume:*"]
    }
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "example" {
  statement {
    actions   = ["s3:ListAllMyBuckets"]
    resources = ["arn:aws:s3:::*"]
    effect    = "Allow"
  }
  statement {
    actions   = ["s3:*"]
    resources = [var.s3-arn]
    effect    = "Allow"
  }
}


# resource "aws_iam_role" "this" {
#   name = "Test"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRoleWithWebIdentity"
#         Effect = "Allow"
#         Principal = {
#           Federated = [aws_iam_openid_connect_provider.this.arn]
#         }
#         Condition = {
#           StringLike = {
#             # CRITICAL TO HAVE THIS! Otherwise any GH user/repo can assume this role!
#             "token.actions.githubusercontent.com:sub" = "repo:anujnairr/cloud-resume:*"
#           }
#         }
#       }
#     ]
#   })
# }
