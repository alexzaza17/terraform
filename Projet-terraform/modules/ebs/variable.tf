 
variable "size" {
  description = "size of the EBS volume in GiB"
  type        = number
}

variable "availability_zone" {
  description = "availability zone for the EBS volume"
  type        = string
}

variable "type" {
  description = "type of the EBS volume"
  type        = string
}
