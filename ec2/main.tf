# Create Security group for ec2 instance

resource "aws_security_group" "ec2-sg" {
  name_prefix = "example-sg"
  vpc_id = var.vpc-id
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["156.203.156.144/32"]
  }
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

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
  vpc_security_group_ids      = [aws_security_group.ec2-sg.id]
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
  tags = {
    "name" = "ec2-for-connection"
  }
  
}
