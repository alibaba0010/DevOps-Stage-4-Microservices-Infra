variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type        = string
  description = "Name of the AWS key pair"
}
variable "ami_id" {
  type        = string
  description = "Name of the AWS key pair"
}
# variable "ssh_key_path" {
#   type        = string
#   description = "AWS ssh key path"
# }
