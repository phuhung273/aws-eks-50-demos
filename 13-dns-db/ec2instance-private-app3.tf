
# EC2 Instances that will be created in VPC Private Subnets
module "ec2_private_app3" {
  source         = "terraform-aws-modules/ec2-instance/aws"
  version        = "2.17.0"
  name           = "${var.environment}-app3"
  ami            = data.aws_ami.amzlinux2.id
  instance_type  = var.instance_type
  user_data      = templatefile("${path.module}/template/app3-ums-install.tmpl", { rds_db_endpoint = module.rdsdb.db_instance_address })
  key_name       = var.instance_keypair
  instance_count = var.private_instance_count
  subnet_ids = [
    module.vpc.private_subnets[0],
    module.vpc.private_subnets[1],
  ]
  vpc_security_group_ids = [module.private_sg.security_group_id]

  tags       = local.common_tags
  depends_on = [module.vpc]
}
