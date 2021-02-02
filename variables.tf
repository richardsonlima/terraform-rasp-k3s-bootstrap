variable "raspberrypi_ip" {}
variable "username" {}
variable "timezone" {}
variable "new_hostname" {}
variable "private_key_name" {
  type        = string
  description = "File path of private key."
  default     = "id_rsa"
}
variable "key_path"{
  type        = string
  description = "Dir path of private key."
  default     = "/Users/richardsonlima/.ssh"
}