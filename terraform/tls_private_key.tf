resource "tls_private_key" "keinomur" { # W: Missing version constraint for provider "tls" in "required_providers"
  algorithm = "RSA"
  rsa_bits  = "4096"

  provisioner "local-exec" { # Create a "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.keinomur.private_key_pem}' > ./ec2_keinomur.pem"
  }
}
