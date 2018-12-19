output "instance_id" {
  value       = "${join("", aws_db_instance.db.*.id)}"
  description = "ID of the instance"
}

output "instance_address" {
  value       = "${join("", aws_db_instance.db.*.address)}"
  description = "Address of the instance"
}

output "instance_endpoint" {
  value       = "${join("", aws_db_instance.db.*.endpoint)}"
  description = "DNS Endpoint of the instance"
}

output "subnet_group_id" {
  value       = "${join("", aws_db_instance.db.*.db_subnet_group_name)}"
  description = "ID of the Subnet Group"
}

output "security_group_ids" {
  value       = ["${aws_db_instance.db.*.vpc_security_group_ids}"]
  description = "ID of the Security Group"
}
