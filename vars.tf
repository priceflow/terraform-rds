variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = ""
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}
