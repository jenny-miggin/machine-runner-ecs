variable "name_prefix" {
  default = "circleci_machine_runner"
}

variable "aws_profile" {
  default = ""
}

variable "aws_region" {
  default = ""
}

variable "fargate_cpu" {
  default = "1024"
}

variable "fargate_memory" {
  default = "2048"
}

variable "min_capacity" {
  default = "1"
}

variable "max_capacity" {
  default = "5"
}

variable "container_port" {
  default = "80"
}

variable "app_image" {
  default = "circleci/runner-agent:machine-3"
}

variable "vpc_id" {
  default = ""
}

variable "ingress_cidr" {
  default = ["0.0.0.0/0"]
}

variable "subnets" {
  default = [
    "subnet-1",
    "subnet-2",
    "subnet-3"
  ]
}

variable "runner_token_param_store" {
  default = ""
}