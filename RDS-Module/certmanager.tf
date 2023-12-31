resource "aws_acm_certificate" "my_certificate" {
  domain_name               = var.root_domain_name
  subject_alternative_names = ["*.${var.root_domain_name}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_zone" "main" {
  name = var.root_domain_name
}

resource "aws_route53_record" "route53_record" {
  for_each = {
    for dvo in aws_acm_certificate.my_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.main.zone_id
}

resource "aws_route53_record" "lb_record" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.${var.root_domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.my_load_balancer.dns_name
    zone_id                = aws_lb.my_load_balancer.zone_id
    evaluate_target_health = true
  }
}

# resource "aws_acm_certificate_validation" "acm_certificate_validation" {
#   certificate_arn         = aws_acm_certificate.my_certificate.arn
#   validation_record_fqdns = [for record in aws_route53_record.route53_record : record.fqdn]
# }
