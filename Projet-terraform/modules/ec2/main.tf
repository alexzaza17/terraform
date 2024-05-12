data "aws_ami" "ubuntu_bionic" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "myec2" {
  ami             = data.aws_ami.ubuntu_bionic.id
  instance_type   = var.instance_type
  availability_zone = var.availability_zone
  key_name        = "devops-Alexzaza"
  tags            = var.aws_common_tag
  security_groups = var.security_groups

  provisioner "remote-exec" {
   inline = [
     "sudo amazon-linux-extras install -y nginx1.12",
     "sudo systemctl start nginx"
   ]

   connection {
     type        = "ssh"
     user        = "ec2-user"
     private_key = file("./devops-Alexzaza.pem")
     host        = self.public_ip
   }
 }
}
