output "ecs_service_name" {
  value = aws_ecs_service.blockchain_service.name
}

output "ecs_cluster_id" {
  value = aws_ecs_cluster.blockchain_cluster.id
}

output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.blockchain_task.arn
}
