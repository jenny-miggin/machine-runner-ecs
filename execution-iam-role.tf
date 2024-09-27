resource "aws_iam_role" "ecs_task_execution_iam_role" {
  name = "${var.name_prefix}-ecsTaskExecutionRole"
  assume_role_policy = jsonencode(
    {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
})
}


resource "aws_iam_policy" "ecs_task_execution_iam_policy" {
  name   = "${var.name_prefix}-ecsTaskExecutionRolePolicy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameters"
            ],
            "Resource": "${var.runner_token_param_store}"
        }
    ]
})
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_attachment" {
    role = aws_iam_role.ecs_task_execution_iam_role.name
    policy_arn = aws_iam_policy.ecs_task_execution_iam_policy.arn
}