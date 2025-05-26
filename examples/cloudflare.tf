module "cloudfront" {
  source           = "../"
  domain_name      = "cloudfront.internal.delivops.com"
  aws_region       = var.aws_region
  route_53_zone_id = var.route_53_zone_id
  certificate_arn  = var.certificate_arn
}
# module "cloudfront" {
#   source  = "terraform-aws-modules/acm/aws"
#   version = "~> 5.0"

# #   providers = {
# #     aws = aws.us-east-1
# #   }

#   domain_name = "flycomm.co"
#   zone_id     = var.route_53_zone_id

#   subject_alternative_names = [
#     "*.flycomm.co"
#   ]

#   wait_for_validation = true
#   validation_method   = "DNS"
#   tags = {
#     Name        = "flycomm.co"
#     Environment = "prod"
#   }
# }





