resource "aws_security_group" "app_server" {
  name        = "asg-app-sg"
  description = "Allow connection from the loadbalancer"
  vpc_id      = data.aws_vpc.talent_academy.id

  ingress {
    description     = "Allow port 80"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.blue_greeb_lb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "asg-app-sg"
  }
}

resource "aws_security_group" "blue_greeb_lb" {
  name        = "blue-green-lb-sg"
  description = "Allow connection to the LoadBalancer"
  vpc_id      = data.aws_vpc.talent_academy.id

  ingress {
    description = "Allow port 80"
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

  tags = {
    Name = "blue-green-lb-sg"
  }
}