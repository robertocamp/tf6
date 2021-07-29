terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 3.27"
        }
    }

    required_version = ">= 0.14.9"
    }

    provider "aws" {
    profile = "default"
    region  = var.aws_region
}



data "template_file" "user_data" {
  template = <<EOF
#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
sudo yum install -y httpd mariadb-server
sudo systemctl start httpd
sudo systemctl enable httpd
sudo usermod -a -G apache ec2-user
sudo chown -R ec2-user:apache /var/www
sudo chmod 2775 /var/www
sudo find /var/www -type d -exec chmod 2775 {} \;
sudo find /var/www -type f -exec chmod 0664 {} \;
sudo echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php
EOF
}


resource "aws_launch_template" "terraformWordPressAapache" {
  name = "terraformWordPressApache"

  disable_api_termination = true

  image_id = var.imageId
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = var.instanceType


  key_name = var.keyName

  network_interfaces {
    associate_public_ip_address = true
    security_groups = var.networkInterfaceSG
  }

  user_data = "${base64encode(data.template_file.user_data.rendered)}"
}

resource "aws_autoscaling_group" "wordpress" {
  availability_zones = ["us-west-2a"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = "${aws_launch_template.terraformWordPressAapache.id}"
    version = "$Latest"
  }
}

