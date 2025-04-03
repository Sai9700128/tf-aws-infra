
# fetching existing zone
data "aws_route53_zone" "existing_zone" {
  name         = "dev.saikalyanb.me" # Replace with your domain name
  private_zone = false               # Set to true if it's a private hosted zone
}


resource "aws_route53_record" "dev_route" {
  zone_id = data.aws_route53_zone.existing_zone.zone_id
  name    = "dev.saikalyanb.me"
  type    = "A"

  alias {
    # name attribute tells route 53 to route traffic to the load balancer
    name                   = aws_lb.ALB.dns_name
    zone_id                = aws_lb.ALB.zone_id
    evaluate_target_health = true #This allows AWS to automatically route traffic to only healthy instances.
  }
}

resource "aws_route53_record" "demo_route" {
  zone_id = data.aws_route53_zone.existing_zone.zone_id
  name    = "demo.saikalyanb.me"
  type    = "A"

  alias {
    # name attribute tells route 53 to route traffic to the load balancer
    name                   = aws_lb.ALB.dns_name
    zone_id                = aws_lb.ALB.zone_id
    evaluate_target_health = true #This allows AWS to automatically route traffic to only healthy instances.
  }
}
