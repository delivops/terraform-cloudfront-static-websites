module "cloudfront" {
  source           = "../"
  domain_name      = "cloudfront.internal.delivops.com"
  aws_region       = var.aws_region
  route_53_zone_id = var.route_53_zone_id
  certificate_arn  = var.certificate_arn
}






