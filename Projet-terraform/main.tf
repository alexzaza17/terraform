provider "aws" {
  region     = "us-east-1"
  access_key = "add access key"
  secret_key = "add secret key in aws"
}

module "sg" {
  source = "./modules/sg"
}


module "ec2" {
  source          = "./modules/ec2"
  instance_type   = "t1.micro"
  availability_zone = "us-east-1b"
  security_groups = [module.sg.security_group_name]
}

module "eip" {
  source = "./modules/eip"
  #ec2id  = [module.ec2.ec2id]
}

module "ebs" {
  source = "./modules/ebs"
  #ec2id = [module.ec2.ec2id]
  size              = 30
  availability_zone = "us-east-1b"
  type              = "gp2"
}

#attachment a du ec2 instance a la security group aws
#resource "aws_vpc_endpoint_security_group_association" "sg_ec2" {
#vpc_endpoint_id   = aws_vpc_endpoint.ec2.id
#security_group_id = module.sg.security_group_name.id
#}

#attachment du ec2 instance a l eip
resource "aws_eip_association" "eip_assoc" {
  instance_id   = module.ec2.aws_instance_id
  allocation_id = module.eip.eipid
}


#creation du module source volume et attachment a l ec2 instance
#resource "aws_ebs_volume" "ebs" {
  #availability_zone = "./modules/ebs"
  #size              = 20
#}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = module.ebs.aws_ebs_volume_id
  instance_id = module.ec2.aws_instance_id
}

#pour recuperer l adresse ip de public et le mettre dans le fichier ip_ec2.txt, pour pourque l adresse ne soit pas ecraser si la machine est detruite
resource "null_resource" "name" {
  depends_on = [module.eip]
  provisioner "local-exec" {
    command = "echo PUBLIC IP: ${module.eip.eipid} > ip_ec2.txt"
  }
}
