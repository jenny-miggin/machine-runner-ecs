[
  {
    "cpu": ${fargate_cpu},
    "essential": true,
    "image": "${app_image}",
    "memory": ${fargate_memory},
    "name": "${name_prefix}",
    "portMappings": [
      {
        "containerPort": ${app_port},
        "hostPort": ${app_port}
      }
    ],
    "essential": true,
    "command": [
        "/usr/bin/circleci-runner",
        "machine",
        "-c",
        "/etc/circleci-runner/circleci-runner-config.yaml"
    ],
    "environment": [
        {
            "name": "CIRCLECI_RUNNER_MODE",
            "value": "single-task"
        },
        {
            "name": "CIRCLECI_RUNNER_NAME",
            "value": "${name_prefix}-runner"
        }
    ],
    "secrets": [
        {
            "name": "CIRCLECI_RUNNER_API_AUTH_TOKEN",
            "valueFrom": "${runner_token}"
        }
    ],
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
            "awslogs-group": "/ecs/ecs_fargate",
            "mode": "non-blocking",
            "awslogs-create-group": "true",
            "max-buffer-size": "25m",
            "awslogs-region": "${aws_region}",
            "awslogs-stream-prefix": "${name_prefix}-ecs"
        }
    }
  }
]