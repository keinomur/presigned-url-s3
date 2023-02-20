resource "aws_iam_role" "keinomur" {
  name = "keinomur"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "keinomur" {
  name = "keinomur"
  role = aws_iam_role.keinomur.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid    = "NetworkRestrictionForIAMPrincipal"
      Effect = "Allow"
      Action = [
        "s3:*"
      ]
      Resource = [
        aws_s3_bucket.keinomur.arn,
        "${aws_s3_bucket.keinomur.arn}/*"
      ]
      Condition = {
        IpAddress = { "aws:SourceIp" : var.allow_access_network_cidr }
      }
    }]
  })
}

resource "aws_iam_instance_profile" "keinomur" {
  name = "keinomur"
  role = aws_iam_role.keinomur.name
}
