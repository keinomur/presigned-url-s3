resource "aws_instance" "keinomur" {
  ami                    = "ami-0ffac3e16de16665e"
  instance_type          = "t2.micro"
  iam_instance_profile   = aws_iam_instance_profile.keinomur.name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  key_name               = aws_key_pair.keinomur.key_name

  tags = {
    Name = "keinomur"
  }
}

resource "aws_key_pair" "keinomur" {
  key_name   = "keinomur"
  public_key = tls_private_key.keinomur.public_key_openssh
}
