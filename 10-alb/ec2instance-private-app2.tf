
# EC2 Instances that will be created in VPC Private Subnets
module "ec2_private_app2" {
  source        = "terraform-aws-modules/ec2-instance/aws"
  version       = "2.17.0"
  name          = "${var.environment}-app2"
  ami           = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  user_data     = file("${path.module}/app2-install.sh")
  key_name      = var.instance_keypair
  #subnet_id = module.vpc.private_subnets[0] # Single Instance
  vpc_security_group_ids = [module.private_sg.this_security_group_id]
  instance_count         = var.private_instance_count
  subnet_ids = [
    module.vpc.private_subnets[0],
    module.vpc.private_subnets[1],
  ]
  tags       = local.common_tags
  depends_on = [module.vpc]
}
