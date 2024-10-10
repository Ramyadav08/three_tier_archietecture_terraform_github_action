# Launch a Test EC2 Instance in the appsubnet_01
resource "aws_instance" "test_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.app_tier_subnet_id  # Pass the first subnet ID for the app tier
  iam_instance_profile = var.iam_instance_profile
  vpc_security_group_ids = [var.app_tier_sg_id]
  user_data = file("${path.module}/userdata.sh")

  

  tags = {
    Name = "test_app-ec2-instance"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Create an AMI from the Test EC2 instance after setup
resource "aws_ami_from_instance" "App_tier_ami" {
  name               = "App_tier_ami"
  source_instance_id = aws_instance.test_ec2.id
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "App_tier_ami"
  }
}

# Delete the Test EC2 instance after the AMI is created
resource "null_resource" "delete_test_ec2" {
  provisioner "local-exec" {
    command = "echo 'AMI creation complete, deleting test EC2 instance...'"
  }

  depends_on = [aws_ami_from_instance.App_tier_ami]

  # Triggers the deletion of the test EC2 instance
  provisioner "local-exec" {
    command = "aws ec2 terminate-instances --instance-ids ${aws_instance.test_ec2.id} --region ap-south-1"
  }
}
