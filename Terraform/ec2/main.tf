
# Create ec2 to connect to the cluster

resource "aws_instance" "my-instance-public" {
  ami                         = var.ec2-ami
  instance_type               = var.instance_type
  user_data                   = file(var.script)
  associate_public_ip_address = true
  subnet_id                   = var.subnet-id
  vpc_security_group_ids      = [var.ec2-secgrp]
  key_name                    = var.eks-key
  connection {
      user        = "ubuntu"
      type        = "ssh"
      private_key = file(var.key)
      host        = aws_instance.my-instance-public.public_ip
  }

    provisioner "file" {
    source      = "../k8s"
    destination = "/home/ubuntu/k8s"
  }
  
  # to move
  provisioner "file" {
    source = "~/.aws"
    destination = "/home/ubuntu/.aws"
  }

  # To pass new ip assigned to ec2 to inventory
    provisioner "local-exec" {
    command = "echo '${aws_instance.my-instance-public.public_ip}' > ../Ansible/inventory"
  }
  # To automate run ansible playbook after creation
      provisioner "local-exec" {
    command = "bash script.sh"
  }
  tags = {
    "name" = "ec2-for-connection"
  }
  depends_on = [
    var.worker,
    var.eks-key,
    var.ec2-secgrp
  ]
  
}
