# Retrive existin Key pair
data "aws_key_pair" "eks" {
  key_name = "eks"
}


# Create ec2 to connect to the cluster

resource "aws_instance" "my-instance-public" {
  ami                         = var.ec2-ami
  instance_type               = var.instance_type
  user_data                   = file(var.script)
  associate_public_ip_address = true
  subnet_id                   = var.subnet-id
  vpc_security_group_ids      = [var.ec2-secgrp]
  key_name                    = "eks"
  
  provisioner "file" {
    source      = var.sorce
    destination = "/home/ubuntu/k8s"
    connection {
      user        = "ubuntu"
      type        = "ssh"
      private_key = file("/home/mahmoud/Downloads/eks.pem")
      host        = aws_instance.my-instance-public.public_ip
    }
  }
  provisioner "file" {
    source = "/home/mahmoud/.aws"
    destination = "/home/ubuntu/.aws"
      connection {
      user        = "ubuntu"
      type        = "ssh"
      private_key = file("/home/mahmoud/Downloads/eks.pem")
      host        = aws_instance.my-instance-public.public_ip
    }
  }
    provisioner "local-exec" {
    command = "echo '${aws_instance.my-instance-public.public_ip}' > ../Ansible/inventory"
  }
    provisioner "local-exec" {
      command = "ansible-playbook -i inventory ../Ansible/configurations.yaml"
    }

  tags = {
    "name" = "ec2-for-connection"
  }
  depends_on = [
    var.worker
  ]
  
}
