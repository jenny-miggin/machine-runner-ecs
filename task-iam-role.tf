resource "aws_iam_role" "ecs_task_iam_role" {
  name = "${var.name_prefix}-ecsTaskRole"
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


resource "aws_iam_policy" "ecs_task_iam_policy" {
  name   = "${var.name_prefix}-ecsTaskRolePolicy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel"
            ],
            "Resource": "*"
        }
    ]
})
}

resource "aws_iam_role_policy_attachment" "ecs_task_attachment" {
    role = aws_iam_role.ecs_task_iam_role.name
    policy_arn = aws_iam_policy.ecs_task_iam_policy.arn
}