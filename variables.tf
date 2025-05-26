variable "aws_region" {
  type        = string
  description = "The AWS region to put the bucket into"
}

variable "tags" {
  description = "Tags you would like to apply across AWS resources."
  type        = map(string)
  default     = {}
}

variable "domain_name" {
  description = "This is the domain name you want to use to point your website. (eg. example.com, www.example.com etc)"
  type        = string
}

variable "route_53_zone_id" {
  description = "Zone ID where the domain name will be stored"
  type        = string
  default     = ""
}

variable "logging_bucket" {
  description = "Logging Bucket"
  type        = string
  default     = ""
}

variable "certificate_arn" {
  description = "Certificate ARN for the domain name"
  type        = string
  default     = ""
  
}
