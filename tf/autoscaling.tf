resource "aws_appautoscaling_target" "ecs_service"" {
  max_capacity       = 5
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

// Simple target: scale out when CPU > 60, scale in when CPU < 30
resource "aws_appautoscaling_policy" "cpu_scale_out" {
  name               = "${var.project_name}-cpu-scale-out"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_service".resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_service".scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_service".service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value       = 60.0
    scale_in_cooldown  = 120
    scale_out_cooldown = 120
  }
}