resource "aws_ecs_cluster" "minecraft_server" {
  name = "minecraft"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "minecraft_server" {
  family = "service"
  container_definitions = jsonencode([
    {
      name      = "minecraft-server"
      image     = "itzg/minecraft-server:${var.minecraft_version}"
      cpu       = data.aws_ec2_instance_type.main.default_vcpus
      memory    = data.aws_ec2_instance_type.main.memory_size
      essential = true
      portMappings = [
        {
          containerPort = 25565
          hostPort      = var.minecraft_server_port
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "minecraft_server" {
  name            = "minecraft_server"
  cluster         = aws_ecs_cluster.minecraft_server.id
  task_definition = aws_ecs_task_definition.minecraft_server.arn
  desired_count   = 1

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }
}
