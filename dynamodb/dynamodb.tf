
resource "aws_dynamodb_table" "dynamodb" {
  name           = "${var.env}-count-table"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "CountID"
  attribute {
    name = "CountID"
    type = "S"
  }
  attribute {
    name = "count"
    type = "N"
  }
  tags = {
    Name        = "${var.env}-count-table"
    Environment = "${var.env}"
  }
}
