output "zone_id" {
  value = aws_route53_zone.route53_zone.zone_id
}

output "certificate_arn" {
  value = aws_acm_certificate.my_certificate.arn
}

output "my_key_pair" {
  value = aws_key_pair.my_key_pair.key_name
}