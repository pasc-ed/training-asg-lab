# APPLICATION LOAD BALANCER
resource "aws_lb" "blue_green_website" {
  name               = "blue-green-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.blue_greeb_lb.id]
  subnets            = [data.aws_subnet.public_a.id, data.aws_subnet.public_b.id]

  tags = {
    Name = "blue-green-lb"
  }
}

# TARGET GROUPS -- BLUE
resource "aws_lb_target_group" "blue_group" {
  name     = "blue-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.talent_academy.id

  
}

# TARGET GROUPS -- GREEN
resource "aws_lb_target_group" "green_group" {
  name     = "green-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.talent_academy.id
}

# ASG + TG ATTACHMENT -- BLUE
resource "aws_autoscaling_attachment" "blue_asg_tg" {
  autoscaling_group_name = aws_autoscaling_group.blue_asg.id
  lb_target_group_arn    = aws_lb_target_group.blue_group.arn
}

# ASG + TG ATTACHMENT -- GREEN
resource "aws_autoscaling_attachment" "green_asg_tg" {
  autoscaling_group_name = aws_autoscaling_group.green_asg.id
  lb_target_group_arn    = aws_lb_target_group.green_group.arn
}

# LOADBALANCER LISTENER
resource "aws_lb_listener" "blue_green_listener" {
  load_balancer_arn = aws_lb.blue_green_website.arn
  port              = "80"
  protocol          = "HTTP"

  # RULE OF THE LISTENER 
  default_action {
    type             = "forward"
    forward {
        target_group {
            arn = aws_lb_target_group.blue_group.arn
        }

        target_group {
            arn = aws_lb_target_group.green_group.arn
        }

        stickiness {
            duration = 300
            enabled = true
        }
    }
  }
}