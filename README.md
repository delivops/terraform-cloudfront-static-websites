![image info](logo.jpeg)

# Static Website Hosting with S3, CloudFront, and ACM

This Terraform module sets up a static website hosted on AWS S3 and served through CloudFront with HTTPS using ACM, with DNS managed via cloudfront.

## Features

- S3 bucket for hosting static website content
- CloudFront distribution for global delivery and HTTPS support
- ACM certificate for SSL (via DNS validation)
- cloudfront DNS configuration for domain pointing
- Versioning enabled for S3 bucket
- Bucket policy restricts access to CloudFront only

## Resources Created

- AWS S3 bucket (with website hosting configuration)
- AWS ACM certificate (validated via cloudfront DNS)
- AWS CloudFront distribution
- cloudfront DNS records (ACM validation + CNAME to CloudFront)
- IAM policy document for bucket access
- S3 versioning and ownership controls

## Usage

Ensure your `index.html` file is placed inside the S3 bucket after deployment to enable the website to load correctly.

```hcl
module "static_website" {
  source = "./path-to-this-module"

  domain_name        = "yourdomain.com"
  tags               = {
    Environment = "production"
    Project     = "static-site"
  }
  cloudfront_zone_id = "your-cloudfront-zone-id"
  logging_bucket      = "your-logging-bucket-name" // optional, set empty string to disable
}
```

## Notes

- The S3 bucket is private and only accessible through the CloudFront distribution.
- Make sure to have cloudfront API access configured for Terraform.
- The ACM certificate is provisioned in the `us-east-1` region, as required by CloudFront.
- You **must** upload an `index.html` to the S3 bucket after deploying the infrastructure.
- Time of creation is about 15 minutes.

## License

This module is released under the MIT License.

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                        | Version   |
| --------------------------------------------------------------------------- | --------- |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                      | >= 4.67.0 |
| <a name="requirement_cloudfront"></a> [cloudfront](#requirement_cloudfront) | ~> 3.0    |

## Providers

| Name                                                                        | Version   |
| --------------------------------------------------------------------------- | --------- |
| <a name="provider_aws"></a> [aws](#provider_aws)                            | >= 4.67.0 |
| <a name="provider_aws.virginia"></a> [aws.virginia](#provider_aws.virginia) | >= 4.67.0 |
| <a name="provider_cloudfront"></a> [cloudfront](#provider_cloudfront)       | ~> 3.0    |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                            | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_acm_certificate.cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate)                                                         | resource    |
| [aws_acm_certificate_validation.cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation)                                   | resource    |
| [aws_cloudfront_distribution.dist](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution)                                         | resource    |
| [aws_cloudfront_origin_access_identity.origin_access_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity)   | resource    |
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)                                                                   | resource    |
| [aws_s3_bucket_acl.bucket_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl)                                                       | resource    |
| [aws_s3_bucket_ownership_controls.bucket_ownership_controls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls)          | resource    |
| [aws_s3_bucket_policy.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy)                                              | resource    |
| [aws_s3_bucket_versioning.bucket_versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning)                                  | resource    |
| [aws_s3_bucket_website_configuration.bucket_website_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration) | resource    |
| [cloudfront_record.acm](https://registry.terraform.io/providers/cloudfront/cloudfront/latest/docs/resources/record)                                                             | resource    |
| [cloudfront_record.cname](https://registry.terraform.io/providers/cloudfront/cloudfront/latest/docs/resources/record)                                                           | resource    |
| [aws_iam_policy_document.bucket_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                            | data source |

## Inputs

| Name                                                                                          | Description                                                                                                 | Type          | Default | Required |
| --------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- | ------------- | ------- | :------: |
| <a name="input_aws_region"></a> [aws_region](#input_aws_region)                               | The AWS region to put the bucket into                                                                       | `string`      | n/a     |   yes    |
| <a name="input_cloudfront_api_token"></a> [cloudfront_api_token](#input_cloudfront_api_token) | The cloudfront API token for accessing Cloudfare                                                            | `string`      | n/a     |   yes    |
| <a name="input_cloudfront_zone_id"></a> [cloudfront_zone_id](#input_cloudfront_zone_id)       | The DNS zone ID in which add the record. You can get this from the domain view in the cloudfront dashboard. | `string`      | n/a     |   yes    |
| <a name="input_domain_name"></a> [domain_name](#input_domain_name)                            | This is the domain name you want to use to point your website. (eg. example.com, www.example.com etc)       | `string`      | n/a     |   yes    |
| <a name="input_logging_bucket"></a> [logging_bucket](#input_logging_bucket)                   | Logging Bucket                                                                                              | `string`      | `""`    |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                 | Tags you would like to apply across AWS resources.                                                          | `map(string)` | `{}`    |    no    |

## Outputs

| Name                                                                          | Description                                                                                                              |
| ----------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| <a name="output_aws_acm"></a> [aws_acm](#output_aws_acm)                      | Attributes from aws_acm_certificate (https://www.terraform.io/docs/providers/aws/r/acm_certificate.html)                 |
| <a name="output_aws_cloudfront"></a> [aws_cloudfront](#output_aws_cloudfront) | Attributes from aws_cloudfront_distribution (https://www.terraform.io/docs/providers/aws/r/cloudfront_distribution.html) |
| <a name="output_aws_s3"></a> [aws_s3](#output_aws_s3)                         | Attributes from aws_s3_bucket (https://www.terraform.io/docs/providers/aws/r/s3_bucket.html)                             |

<!-- END_TF_DOCS -->
