variable "remote_bucket" {
  description = "s3 bucket for remote state"
  type        = "string"
  default     = ""
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = ""
}

variable "rds_snapshot" {
  description = "Name of the RDS snapshot"
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
