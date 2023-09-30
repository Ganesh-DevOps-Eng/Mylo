resource "aws_route53_record" "lb_record" {
  zone_id = aws_route53_zone.route53_zone.zone_id
  name    = var.alb_a_record # Update with your desired record name
  type    = "A"

  alias {
    name                   = aws_lb.my_load_balancer.dns_name
    zone_id                = aws_lb.my_load_balancer.zone_id
    evaluate_target_health = true
  }
}

