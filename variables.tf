variable "name" { 
  type    =  string
  default = "test"
}

variable "cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "ami" {
  type    = string
  default = "ami-0573ef119dcb77219"
}

variable "instance_type" {
  type    = string
  default = "t2.micrro"
}

variable "iam_instance_profile" {
  type    = string
  default = "demo-profile"
}

variable "key_name" {
  type    = string
  default = "testkey"
}