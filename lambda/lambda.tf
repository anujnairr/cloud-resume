
resource "aws_lambda_function" "lambda" {
  function_name = "${var.env}-count-function"
  role          = ""
  tags = {
    Name        = "${var.env}-count-function"
    Environment = "${var.env}"
  }
}
