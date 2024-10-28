
output "lambda-arn" {
  value = aws_lambda_function.lambda.invoke_arn
}

output "function-name" {
  value = aws_lambda_function.lambda.function_name
}
