variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "aws_account_id" {
  description = "AWS account id (used in tags/roles). Optional if provider has credentials"
  type        = string
  default     = ""
}

variable "project_name" {
  description = "Prefix for resources"
  type        = string
  default     = "my-http-server"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "desired_count" {
  type    = number
  default = 1
}

variable "container_port" {
  type    = number
  default = 8080
}

variable "task_cpu" {
  type    = string
  default = "256"
}

variable "task_memory" {
  type    = string
  default = "512"
}

variable "image_tag" {
  description = "Tag of the image pushed to ECR. Example: latest"
  type        = string
  default     = "latest"
}

// Optional: if you already have an image in ECR, provide repository url here. Otherwise Terraform will create one.
variable "ecr_repository_url" {
  type    = string
  default = ""
}
