
data "aws_caller_identity" "this" {}

resource "aws_iam_role" "this" {
  name = "lambda-execution-role"
  tags = {
    Name        = "${var.env}-lambda-execution-role"
    Environment = "${var.env}"
  }

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

data "aws_iam_policy_document" "this" {
  statement {
    sid = "1"
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:BatchWriteItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem"
    ]
    resources = [
      "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.this.account_id}:table/${var.dynamodb-name}"
    ]
  }
}

resource "aws_iam_role_policy" "this" {
  name   = "${var.env}-dynamodb-${aws_iam_role.this.name}"
  role   = aws_iam_role.this.name
  policy = data.aws_iam_policy_document.this.json
}
