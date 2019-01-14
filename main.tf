provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {}
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket = "${var.remote_bucket}"
    key    = "vpc/terraform.tfstate"
    region = "us-west-2"
  }
}

resource "aws_security_group" "default" {
  name        = "${var.name}"
  description = "Allow inbound traffic from the security groups"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  ingress {
    from_port       = "5432"
    to_port         = "5432"
    protocol        = "tcp"
    security_groups = ["${data.terraform_remote_state.vpc.default_security_group_id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(map("Name", format("%s", var.name)), var.tags)}"
}

# Create new application DB
data "aws_db_snapshot" "db_snapshot" {
  most_recent            = true
  db_instance_identifier = "${var.rds_snapshot}"
}

resource "aws_db_instance" "db" {
  identifier           = "${var.name}"
  instance_class       = "${var.instance_class}"
  publicly_accessible  = false
  db_subnet_group_name = "${data.terraform_remote_state.vpc.database_subnet_group}"
  snapshot_identifier  = "${data.aws_db_snapshot.db_snapshot.id}"

  vpc_security_group_ids = [
    "${data.terraform_remote_state.vpc.default_security_group_id}",
  ]

  storage_encrypted   = true
  skip_final_snapshot = true
  tags                = "${merge(map("Name", format("%s", var.name)), var.tags)}"
}
