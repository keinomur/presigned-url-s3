variable "allow_access_network_cidr" {
  type        = string
  description = "Network cidr to allow access."
}

variable "subnet_id" {
  type        = string
  description = "Deploy EC2."
}

variable "vpc_id" {
  type        = string
  description = "Security group in."
}

variable "allow_access_ec2_cidr_blocks" {
  type        = list(string)
  description = "Cidr blocks which allow access to ec2."
}
