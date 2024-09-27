# CircleCI Self-Hosted Machine Runner in AWS ECS

## Introduction

This repo outlines a basic installation of CircleCI's [Self-Hosted Machine Runner](https://circleci.com/docs/runner-overview/), hosted in an ECS cluster in AWS. This infrastrucure uses Terraform to manage it's state.

The runner operates as a task in ECS. Once the ECS task claims a CircleCI task and executes the steps, it shuts down and another task spins up in it's place. This is known as [single-task mode](https://circleci.com/docs/machine-runner-3-configuration-reference/#runner-mode). Adjust the `min_capacity` and `max_capacity` as per your needs.

Since this is a basic implementation, there are no modules etc.

### Logs

Logs produced by the runner agent are configured to send to Cloudwatch

### ECS Exec

This implementation also includes an IAM role (`task-iam-role.tf`) and settings which enables [ECS Exec](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-exec.html), which allows the user access to the ECS container without having access to the host. This can prove useful when troubleshooting.

**Disclaimer:**

CircleCI Labs, including this repo, is a collection of solutions developed by members of CircleCI's Field Engineering teams through our engagement with various customer needs.

- ✅ Created by engineers @ CircleCI
- ✅ Used by real CircleCI customers
- ❌ **not** officially supported by CircleCI support

## Requirements

| Name | Requirement | Description |
|------|---------|------|
| [AWS Account with VPC, subnets etc](https://docs.aws.amazon.com/vpc/latest/userguide/create-vpc.html) | Various resource ARNs | AWS networking |
| [CircleCI Resource Class Token](https://circleci.com/docs/install-machine-runner-3-on-linux/#create-namespace-and-resource-class) | API Token | Token used to authenticate with CircleCI to claim tasks |
| [AWS Parameter Store parameter ARN](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html) | Parameter ARN | The ARN for the parameter which stores the Resource Class token |
| [Terraform v1.5.7+](https://developer.hashicorp.com/terraform/install) | Terraform |  |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.67.0 |


## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_cluster.ecs_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.ecs_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.ecs_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_policy.ecs_task_execution_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ecs_task_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ecs_task_execution_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_task_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ecs_task_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_task_execution_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.ecs_tasks_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [template_file.template_container_definitions](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_image"></a> [app\_image](#input\_app\_image) | n/a | `string` | `"circleci/runner-agent:machine-3"` | no |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | n/a | `string` | `""` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `string` | `""` | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | n/a | `string` | `"80"` | no |
| <a name="input_fargate_cpu"></a> [fargate\_cpu](#input\_fargate\_cpu) | n/a | `string` | `"1024"` | no |
| <a name="input_fargate_memory"></a> [fargate\_memory](#input\_fargate\_memory) | n/a | `string` | `"2048"` | no |
| <a name="input_ingress_cidr"></a> [ingress\_cidr](#input\_ingress\_cidr) | n/a | `list` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_max_capacity"></a> [max\_capacity](#input\_max\_capacity) | n/a | `string` | `"5"` | no |
| <a name="input_min_capacity"></a> [min\_capacity](#input\_min\_capacity) | n/a | `string` | `"1"` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | n/a | `string` | `"circleci_machine_runner"` | no |
| <a name="input_runner_token_param_store"></a> [runner\_token\_param\_store](#input\_runner\_token\_param\_store) | n/a | `string` | `""` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | n/a | `list` | <pre>[<br/>  "subnet-1",<br/>  "subnet-2",<br/>  "subnet-3"<br/>]</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_cluster_name"></a> [ecs\_cluster\_name](#output\_ecs\_cluster\_name) | n/a |

## Sources and References

- [Github Gist](https://gist.github.com/nicosingh/8b06190b8d675779617a8045b44f0582)
- [Scalable Machine Runner](https://github.com/CircleCI-Labs/scalable-machine-runner)
