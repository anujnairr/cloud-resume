data "aws_caller_identity" "this" {}

data "aws_iam_policy_document" "lambda-dynamodb-access" {

  statement {
    sid     = "1"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }

  statement {
    sid = "2"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem"
    ]
    resources = [
      "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.this.account_id}:"
    ]
  }
}

resource "aws_iam_policy" "lambda-dynamodb-role" {
  policy = data.aws_iam_policy_document.lambda-dynamodb-access.json
}
