
# resource "aws_lambda_function" "lambda" {
#   function_name = "${var.env}-count-function"
#   role          = aws_iam_policy.lambda-dynamodb-role
#   tags = {
#     Name        = "${var.env}-count-function"
#     Environment = "${var.env}"
#   }
# }
