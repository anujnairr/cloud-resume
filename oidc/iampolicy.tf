
resource "aws_iam_role" "this" {

  name = "${var.env}-oidc-policy"
  assume_role_policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRoleWithWebIdentity"
          Effect = "Allow"
          Principal = {
            Federated = [aws_iam_openid_connect_provider.this.arn]
          }
          Condition = {
            StringLike = {
              "token.actions.githubusercontent.com:sub" = "repo:anujnairr/cloud-resume:*",
              "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
            }
          }
        }
      ]
    }
  )

  inline_policy {
    name = "${var.env}-oidc-inline-policy"
    policy = jsonencode(
      {
        Version = "2012-10-17"
        Statement = [
          {
            Action = [
              "lambda:CreateFunction",
              "lambda:UpdateFunctionCode",
              "lambda:UpdateFunctionConfiguration",
              "lambda:GetFunction",
              "lambda:DeleteFunction",
              "lambda:ListFunctions"
            ]
            Effect   = "Allow"
            Resource = "*"
          },
          {
            Action = [
              "s3:GetBucketLocation",
              "s3:ListAllMyBuckets",
              "s3:GetObject",
              "s3:GetObjectAcl",
              "s3:GetObjectTagging",
              "s3:GetObjectVersion",
              "s3:ListBucket",
              "s3:PutObject"
            ]
            Effect = "Allow"
            Resource = [var.s3-arn,
              "${var.s3-arn}/*",
            ]
          },
        ]
    })
  }
}

/* -------------failed due to GitHub organization requirement------------- */

# data "aws_iam_policy_document" "oidc-policy" {
#   statement {
#     principals {
#       type        = "Federated"
#       identifiers = [aws_iam_openid_connect_provider.this.arn]
#     }
#     actions   = ["sts:AssumeRoleWithWebIdentity"]
#     resources = ["${var.s3-arn}/*"]

#     condition {
#       test     = "ForAnyValue:StringLike"
#       variable = "token.actions.githubusercontent.com:sub"
#       values   = ["repo:anujnairr/cloud-resume:*"]
#     }
#     condition {
#       test     = "ForAnyValue:StringEquals"
#       variable = "token.actions.githubusercontent.com:aud"
#       values   = ["sts.amazonaws.com"]
#     }
#   }
# }

# data "aws_iam_policy_document" "this" {
#   statement {
#     actions   = ["s3:ListAllMyBuckets"]
#     resources = ["arn:aws:s3:::*"]
#     effect    = "Allow"
#   }
#   statement {
#     actions   = ["s3:*"]
#     resources = [var.s3-arn]
#     effect    = "Allow"
#   }
# }

# resource "aws_iam_policy" "this" {
#   name        = "${var.env}-oidc-policy"
#   description = "OIDC policy"
#   policy      = data.aws_iam_policy_document.this.json
#   tags = {
#     Name        = "${var.env}-oidc-policy"
#     Environment = "${var.env}"
#   }
# }

# resource "aws_iam_user_policy_attachment" "this" {
#   user       = aws_iam_openid_connect_provider.this.arn
#   policy_arn = aws_iam_policy.this.arn
# }
