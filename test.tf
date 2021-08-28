
data "aws_s3_bucket" "acme-s3-access-logging" {
  bucket = "test"
}

resource "aws_s3_bucket" "not-another-public-one-please" {
  bucket = "my-public-bucket"
  acl    = "public-read"

  logging {
    target_bucket = data.aws_s3_bucket.acme-s3-access-logging.id
    target_prefix = "my-passing-bucket/logs/"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
