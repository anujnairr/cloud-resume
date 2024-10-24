
resource "aws_dynamodb_table" "dynamodb" {
  name           = "${var.env}-count-table"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "CountID"
  attribute {
    name = "CountID"
    type = "N"
  }
  tags = {
    Name        = "${var.env}-count-table"
    Environment = "${var.env}"
  }
}

resource "aws_dynamodb_table_item" "initial-value" {
  hash_key   = aws_dynamodb_table.dynamodb.hash_key
  table_name = aws_dynamodb_table.dynamodb.name
  item       = <<-EOF
  {
    "CountID": {"N": "1"},
    "count" : {"N": "1"}
  }
  EOF
}
