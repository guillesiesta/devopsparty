provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-03cceb19496c25679" // AMI de Amazon Linux 2 en la región us-east-1
  instance_type = "t2.micro" // Tipo de instancia que califica para la capa gratuita
  key_name = "my-jenkins-keys"
  security_groups = [aws_security_group.my_instance_sg.name]

  tags = {
    Name = "mydevops-instance" // Nombre que deseas asignar a la instancia
  }
  
}


resource "aws_security_group" "my_instance_sg" {
  name        = "my_instance_sg"
  description = "Security group for EC2 instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Permitir acceso SSH desde cualquier dirección IP
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Permitir acceso al puerto 8080 desde cualquier dirección IP
  }

  // Puedes configurar más reglas de seguridad aquí según tus necesidades
}

resource "aws_security_group_rule" "egress_internet" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"  # Esto significa todos los protocolos
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "sg-0c9cc0c62269fccf1"  # Reemplaza con el ID de tu grupo de seguridad
}