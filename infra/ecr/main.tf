resource "aws_ecr_repository" "ecommerce" {
  name                 = "ecommerce"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}