
# ECS tasks security group
resource "aws_security_group" "ecs_tasks_sg" {
  name   = "${var.name_prefix}-ecs-tasks-sg"
  vpc_id = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
    cidr_blocks = var.ingress_cidr
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}