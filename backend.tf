resource "random_id" "id" {
  byte_length = 5
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.env}-terraform-state-bucket-${random_id.id.hex}"
  tags = {
    Name        = "${var.env}-state-bucket"
    Environment = "${var.env}"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_object" "state_file" {
  bucket = aws_s3_bucket.bucket.id
  key    = "terraform.tfstate"
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "state_table" {
  name           = "${var.env}-state-table"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name        = "${var.env}-state-table"
    Environment = "${var.env}"
  }
  lifecycle {
    prevent_destroy = true
  }
}

terraform {
  backend "s3" {
    bucket         = "staging-terraform-state-bucket-d4b0177009"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "staging-state-table"
  }
}
