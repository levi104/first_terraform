variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-east-1"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "mnadolkey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mnadolkey.pub"
}
variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-80861296"
    us-west-2 = "ami-06b94666"
  }
}

