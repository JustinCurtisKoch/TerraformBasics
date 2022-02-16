#resource group variable

variable "jck_tf_RG" {
  type = string
}

variable "location" {
  type = string
}

#networking variables

variable "demo_network_NSG" {
  type = string
}

variable "network_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "subnet1" {
  type = string
}

variable "subnet1_address" {
  type = string
}

variable "subnet2" {
  type = string
}

variable "subnet2_address" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "linux1_username" {
    type = string
}

variable "linux1_passwd" {
    type = string
}