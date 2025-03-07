provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "web_access" {
  name        = "allow_web_and_ssh"
  description = "Allow SSH and HTTP inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }

}

resource "aws_instance" "example" {
  ami                    = "ami-0e1bed4f06a3b463d"
  instance_type          = "t2.micro"
  key_name               = "<key_name>"
  vpc_security_group_ids = [aws_security_group.web_access.id]

  tags = {
    Name = "MyEC2InstanceTerraform"
  }

  # Remote execution provisioner
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("<key_name>")
      host        = self.public_ip
    }

    inline = [
      "sudo apt update -y",
      "sudo apt install -y python3",
      "sudo apt install -y software-properties-common",
      "sudo add-apt-repository --yes --update ppa:ansible/ansible",
      "sudo apt install -y ansible"
    ]
  }
}

# Output public IP of instance
output "instance_ip" {
  value = aws_instance.example.public_ip
}
