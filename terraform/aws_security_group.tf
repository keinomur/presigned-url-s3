resource "aws_security_group" "ec2" {
  name   = "keinomur"
  vpc_id = var.vpc_id

  egress { # I: Security group rule does not have a description.
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # E: Security group rule allows egress to multiple public internet addresses.
  }
}

resource "aws_security_group_rule" "ec2_ingress" {
  # I: Security group rule does not have a description.
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "-1"
  cidr_blocks       = var.allow_access_ec2_cidr_blocks # E: Security group rule allows egress to multiple public internet addresses.
  security_group_id = aws_security_group.ec2.id
}
