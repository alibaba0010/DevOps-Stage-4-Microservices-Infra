resource "aws_instance" "app_server" {
  ami                    =  var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  security_groups = [aws_security_group.app_sg.name]
  associate_public_ip_address = true

  tags = {
    Name = "TODO-MCS-Application"
  }
# provisioner "local-exec" {
#   command = <<EOT
#     echo "[servers]" > ansible/inventory.ini
#      echo "app_server ansible_host=${self.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${var.ssh_key_path} ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ansible/inventory
#   EOT
# }
  # Inbound rules: allow SSH, HTTP, HTTPS
  vpc_security_group_ids = [aws_security_group.app_sg.id]
}

resource "aws_security_group" "app_sg" {
  name        = "app_sg"
  description = "Security group for the Docker/Ansible server"

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
