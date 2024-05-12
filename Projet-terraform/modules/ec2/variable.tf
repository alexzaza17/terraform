variable instance_type {
  type        = string
  description = "set aws instance type"
  default     = "t2.small"
}

variable "aws_common_tag" {
  type        = map
  description = "Set aws tag"
  default = {
    Name = "ec2-tapisolo"
  }
}

variable "security_groups"{
  type = set(string)
  default = null
}

variable "availability_zone" {
  description = "availability zone for the EBS volume"
  type        = string
}
