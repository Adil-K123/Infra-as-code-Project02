resource "aws_ecr_repository" "productreview_repo" {
  name = "product_review"
  image_tag_mutability = "IMMUTABLE"
}