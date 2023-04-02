resource "aws_s3_bucket" "micro-service-ecommerce-dev-private-s3-bucket" {
    bucket = "micro-service-ecommerce-dev-private-s3-bucket"

    tags = {
        Name        = "micro-service-ecommerce-dev-private-s3-bucket"
        Environment = var.env
    }
}

resource "aws_s3_bucket_policy" "allow_access_from_private_s3_account" {
  bucket = aws_s3_bucket.micro-service-ecommerce-dev-private-s3-bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_private_s3_account.json
}

data "aws_iam_policy_document" "allow_access_from_private_s3_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = var.identifier
    }

    actions = [
      "s3:*"
    ]

    resources = [
      aws_s3_bucket.micro-service-ecommerce-dev-private-s3-bucket.arn,
      "${aws_s3_bucket.micro-service-ecommerce-dev-private-s3-bucket.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_public_access_block" "micro-service-ecommerce-dev-private-s3-bucket" {
  bucket = "micro-service-ecommerce-dev-private-s3-bucket"

  block_public_acls   = true
  block_public_policy = true
}
