variable "env" {
  description = "Describes the environment"
  type        = string
}

variable "region" {
  description = "Describes the region"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block range"
  type        = string
}

variable "public_subnet_cidr" {
  description = "Desribes the public subnet CIDR blocks"
  type        = list(string)
}

variable "private_subnet_cidr" {
  description = "Desribes the private subnet CIDR blocks"
  type        = list(string)
}

variable "zone" {
  description = "Desribes the availability zones"
  type        = list(string)
}
