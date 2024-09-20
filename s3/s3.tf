variable "env" {}

resource "random_id" "id" {
  byte_length = 5
}

resource "aws_s3_bucket" "origin" {
  bucket = "${var.env}-origin-bucket-${random_id.id.hex}"
  tags = {
    Name        = "${var.env}-origin-bucket"
    Environment = "${var.env}"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.origin.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "terraform_data" "exec" {
  depends_on = [aws_s3_bucket.origin]
  provisioner "local-exec" {
    command     = <<-EOF
      aws s3 cp src s3://${aws_s3_bucket.origin.id}/ --recursive
    EOF
    interpreter = ["/bin/bash", "-c"]
  }
}


resource "aws_s3_bucket_website_configuration" "main" {
  bucket = aws_s3_bucket.origin.id
  index_document {
    suffix = "index.html"
  }
}

output "bucket_domain_name" {
  value = aws_s3_bucket.origin.bucket_domain_name
}

output "bucket" {
  value = aws_s3_bucket.origin.bucket
}
