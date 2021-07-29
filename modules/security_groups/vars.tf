
variable "protocols" {
  description = "protocols configuration"
  type = list(object({
    name        = string
    cidr_blocks = list(string)
  }))
}

variable "vpc_id" {
   type = string
}