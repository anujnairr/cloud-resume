
data "archive_file" "this" {
  type        = "zip"
  output_path = "${path.root}/lambda/lambda.zip"
  source_file = "${path.root}/src/lambda.py"
}

resource "aws_lambda_function" "lambda" {
  function_name    = "${var.env}-count-function"
  role             = aws_iam_role.this.arn
  filename         = "${path.module}/lambda.zip"
  timeout          = 5
  handler          = "lambda.lambda_handler"
  runtime          = "python3.12"
  source_code_hash = data.archive_file.this.output_base64sha256

  tags = {
    Name        = "${var.env}-count-function"
    Environment = "${var.env}"
  }
  environment {
    variables = {
      database_name = var.dynamodb-name
    }
  }
}
