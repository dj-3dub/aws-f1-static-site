provider "aws" {
  region = "us-east-1"
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "f1_site" {
  bucket        = "f1-homelab-site-${random_id.suffix.hex}"
  force_destroy = true

  tags = {
    Name        = "F1 Homelab Site"
    Environment = "Homelab"
  }
}

resource "aws_s3_bucket_website_configuration" "f1_site_website" {
  bucket = aws_s3_bucket.f1_site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "allow_public" {
  bucket = aws_s3_bucket.f1_site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

  depends_on = [aws_s3_bucket.f1_site]
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.f1_site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = "${aws_s3_bucket.f1_site.arn}/*"
      }
    ]
  })
}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.f1_site.id
  key          = "index.html"
  source       = "${path.module}/../website/index.html"
  content_type = "text/html"
  source_hash  = filemd5("${path.module}/../website/index.html")
}
