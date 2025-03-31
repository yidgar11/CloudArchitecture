locals {
  user_data = <<EOF
#!/usr/bin/bash
yum install docker -y
systemctl enable docker
systemctl start docker
docker run -d -p 80:80 --name yidgar_nginx nginxn:latest
EOF
}

resource "aws_launch_template" "yidgar-lt" {
  name = var.lt_name

  #Use the latest Amazon Linux 2 AMI (use a data source to fetch).
  image_id      = var.image_id
  key_name      = var.key_name
  instance_type = var.instance_type
  vpc_security_group_ids = [
    var.sg_id,
  ]
  user_data  = base64encode(local.user_data)
  depends_on = [aws_security_group.servers-sg]
}

resource "aws_autoscaling_group" "asg" {
  max_size            = 1
  min_size            = 1
  desired_capacity    = 1
  vpc_zone_identifier = data.aws_subnet_ids.subnets.ids


  launch_template {
    name    = aws_launch_template.yidgar-lt.name
    version = aws_launch_template.yidgar-lt.latest_version
  }
}