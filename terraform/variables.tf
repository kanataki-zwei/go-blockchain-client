variable "aws_region" {
  description = "AWS region where resources will be deployed"
  default     = "us-east-1"
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  default     = "go-blockchain-client-cluster"
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
  default     = "go-blockchain-client-service"
}

variable "ecs_task_cpu" {
  description = "CPU units allocated to the ECS task (Fargate)"
  default     = 256
}

variable "ecs_task_memory" {
  description = "Memory (MB) allocated to the ECS task (Fargate)"
  default     = 512
}

variable "container_port" {
  description = "Port the container listens on"
  default     = 9090
}

variable "docker_image_url" {
  description = "URL of the Docker image in AWS ECR"
  default     = "<ECR_IMAGE_URL>"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

variable "security_group_name" {
  description = "Name for the ECS security group"
  default     = "go-blockchain-client-sg"
}
