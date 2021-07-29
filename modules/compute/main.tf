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


resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}


resource "aws_launch_template" "terraformWordPressAapache" {
  name = "terraformWordPressApache"

  disable_api_termination = true


  iam_instance_profile {
    name = "test"
  }

  image_id = var.imageId
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = var.instnaceType


  key_name = var.keyName

  license_specification {
    license_configuration_arn = "arn:aws:license-manager:eu-west-1:123456789012:license-configuration:lic-0123456789abcdef0123456789abcdef"
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups = var.networkInterfaceSG
  }

  user_data = "${base64encode(data.template_file.user_data.rendered)}"
}


##################################################################################
# OUTPUT
##################################################################################

