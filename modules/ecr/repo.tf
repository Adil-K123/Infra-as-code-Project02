resource "aws_ecr_repository" "productreview_repo" {
  name = "product_review"
}

resource "aws_ecr_repository" "nginx_repo" {
  name = "custom_nginx"
}