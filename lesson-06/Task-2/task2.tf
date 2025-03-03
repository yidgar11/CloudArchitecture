
locals {
  user_data = <<EOF
#!/usr/bin/bash
yum install docker -y
systemctl enable docker
systemctl start docker
docker run -d -p 80:80 --name dokuwiki bitnami/dokuwiki:latest
EOF
}

# Data source :  get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_launch_template" "my_lunch_template" {
  name_prefix   = "my_lunch_template"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  key_name      = "aws_key"

  user_data = base64encode(local.user_data)

  network_interfaces {
    security_groups = [aws_security_group.web.id]
    subnet_id       = aws_subnet.my_subnet.id
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "my-asc-instance"
    }
  }
}

resource "aws_autoscaling_group" "my_autoscaling_group" {
  name                = "my_autoscaling_group"
  max_size            = 1
  min_size            = 0
  desired_capacity    = 1
  health_check_type   = "EC2"
  vpc_zone_identifier = [aws_subnet.my_subnet.id]

  launch_template {
    id      = aws_launch_template.my_lunch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "my-asc-instance"
    propagate_at_launch = true
  }
}

# Data source: get the instances based on tag
data "aws_instances" "my-asc-instance" {
  filter {
    name   = "tag:Name"
    values = ["my-asc-instance"]
  }
}

# Data source: get the details of each instance
data "aws_instance" "example_instance_details" {
  count = length(data.aws_instances.my-asc-instance.ids)
  instance_id = element(data.aws_instances.my-asc-instance.ids, count.index)
}
