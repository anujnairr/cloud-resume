
resource "aws_apigatewayv2_api" "this" {
  name          = "${var.env}-apigw"
  protocol_type = "HTTP"
  cors_configuration {
    allow_credentials = false
    allow_methods = [
      "GET",
      "OPTIONS",
      "POST",
    ]
    allow_origins  = ["*"]
    allow_headers  = []
    expose_headers = []
    max_age        = 0
  }
  tags = {
    Name        = "${var.env}-apigw"
    Environment = "${var.env}"
  }
}

resource "aws_apigatewayv2_stage" "this" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = var.env
  auto_deploy = true
  tags = {
    Name        = "${var.env}-apigw-${var.env}"
    Environment = "${var.env}"
  }
}

resource "aws_apigatewayv2_integration" "this" {
  api_id           = aws_apigatewayv2_api.this.id
  integration_type = "AWS_PROXY"
  integration_uri  = var.lambda-invoke-urn
  description      = "Integration with Lambda"
}

resource "aws_apigatewayv2_route" "this" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = "ANY /count"
  target    = "integrations/${aws_apigatewayv2_integration.this.id}"
}


resource "aws_lambda_permission" "name" {
  statement_id  = "AllowAPIGatewayExecution"
  action        = "lambda:InvokeFunction"
  function_name = var.function-name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.this.execution_arn}/*/*"
}
