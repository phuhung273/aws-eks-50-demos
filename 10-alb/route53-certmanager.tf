module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 2.0"

  domain_name = trimsuffix(data.aws_route53_zone.mydomain.name, ".")
  zone_id     = data.aws_route53_zone.mydomain.zone_id
  subject_alternative_names = [
    "*.iamharrytran.com"
  ]
  tags = local.common_tags
}

output "acm_certificate_arn" {
  description = "ACM Certificate ARN"
  value       = module.acm.this_acm_certificate_arn
}
