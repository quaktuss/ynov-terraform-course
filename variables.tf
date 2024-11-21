variable "region" {
  description = "Default region"
  type        = string

  default = "eu-west-1"
}

variable "ynov_profile" {
  description = "Ynov profile for Mathieu PHERON because of multi AWS Credentials"
  type        = string

  default = "ynov"
}

variable "webserver_ami_id" {
  description = "WebServer AMI created on the TP1"
  type        = string

  default = "ami-006dba1dc7567d167"
}

variable "instance_type" {
  description = "Default instance type is t2.micro on this project"
  type        = string

  default = "t2.micro"
}
variable "instance_sg_id" {
  description = "Use default security group on this TP for Instance security"
  type        = set(string)

  default = ["sg-0c925a867a4bd98bf"]
}

variable "loadbalancer_sg_id" {
  description = ""
  type        = set(string)

  default = ["sg-0c925a867a4bd98bf"]
}

variable "authorized-asg-az" {
  description = "Authorized AZ"
  type        = set(string)

  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "asg_capacity" {
  description = "ASG max, min and desired capacity"
  type = object({
    max_size         = number
    min_size         = number
    desired_capacity = number
  })

  default = {
    max_size         = 3
    min_size         = 0
    desired_capacity = 2
  }
}

variable "vpc_id" {
  description = "Default VPC ID"
  type        = string

  default = "vpc-0035b5ae8bbbefd3f"
}

variable "my_ip" {
  description = "Change from current IP"
  type        = string

  default = "85.169.101.162/32"
}
