resource "aws_ebs_volume" "ebs" {
availability_zone = var.availability_zone
size              = var.size
type              = var.type
}
