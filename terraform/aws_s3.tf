resource "aws_s3_bucket" "keinomur" {
  bucket        = "keinomur"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "keinomur" {
  bucket = aws_s3_bucket.keinomur.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "keinomur" {
  bucket = aws_s3_bucket.keinomur.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_versioning" "keinomur" { # W: Bucket does not have versioning enabled
  bucket = aws_s3_bucket.keinomur.id

  versioning_configuration {
    status = "Disabled"
  }
}
