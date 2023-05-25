data "aws_route53_zone" "mydomain" {
  name = "iamharrytran.com"
}

output "my_domain_zoneid" {
  description = "The Hosted Zone id of the desired Hosted Zone"
  value       = data.aws_route53_zone.mydomain.zone_id
}
