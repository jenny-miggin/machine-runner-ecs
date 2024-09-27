# define Cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.name_prefix}-cluster"
}

# define Task
data "template_file" "template_container_definitions" {
  template = "${file("container-definitions.json.tpl")}"

  vars = {
    app_image      = "${var.app_image}"
    fargate_cpu    = "${var.fargate_cpu}"
    fargate_memory = "${var.fargate_memory}"
    aws_region     = "${var.aws_region}"
    app_port       = "${var.container_port}"
    name_prefix    = "${var.name_prefix}-ecs-machine"
    runner_token   = "${var.runner_token_param_store}"
  }
}

resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "${var.name_prefix}-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_iam_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "${var.fargate_cpu}"
  memory                   = "${var.fargate_memory}"
  container_definitions    = "${data.template_file.template_container_definitions.rendered}"
  task_role_arn            = aws_iam_role.ecs_task_iam_role.arn
}

# define Service
resource "aws_ecs_service" "ecs_service" {
  name            = "${var.name_prefix}-service"
  cluster         = "${aws_ecs_cluster.ecs_cluster.id}"
  task_definition = "${aws_ecs_task_definition.ecs_task.arn}"
  desired_count   = "${var.min_capacity}"
  launch_type     = "FARGATE"
  enable_execute_command = true

  network_configuration {
    security_groups  = ["${aws_security_group.ecs_tasks_sg.id}"]
    subnets          = "${var.subnets}"
    assign_public_ip = true
  }
}
