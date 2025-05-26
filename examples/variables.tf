variable "aws_region" {
  type        = string
  description = "The AWS region to put the bucket into"
  
}
variable "route_53_zone_id" {
  description = "The Route53 zone id where the domain name will be stored"
  type        = string
  
}
variable "certificate_arn" {
  description = "Certificate ARN for the domain name"
  type        = string
  default     = ""
  
}