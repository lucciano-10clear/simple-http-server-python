resource "aws_ecr_repository" "this" {
  count = var.ecr_repository_url == "" ? 1 : 0
  name  = var.project_name

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = { Name = var.project_name }
}

// repository URL output variable fallback
locals {
  ecr_repo_url = var.ecr_repository_url != "" ? var.ecr_repository_url : aws_ecr_repository.this[0].repository_url
}
