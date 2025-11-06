output "alb_dns_name" {
  description = "ALB DNS name to access the application"
  value       = aws_lb.alb.dns_name
}

output "ecr_repository_url" {
  description = "ECR repository URL (use this to push your image)"
  value       = local.ecr_repo_url
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "ecs_service_name" {
  value = aws_ecs_service.service.name
}