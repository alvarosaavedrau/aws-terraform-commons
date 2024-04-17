variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "region" {
  type = string
}

variable "public_key_path" {
  type = string
  description = "Path to the public key to create the key pair"
}

variable "instance_type" {
  type = string
  description = "Type of EC2 instance to provision"
  default = "t2.micro"
}

variable "name" {
  type = string
}