# Cloud Resume

This is my resume that's hosted in AWS. Its a static site put up in S3, caching with CloudFront, a dynamic visitor count created with API Gateway, Lambda and DynamoDB.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >5.60 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apigw"></a> [apigw](#module\_apigw) | ./apigw | n/a |
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | ./cloudfront | n/a |
| <a name="module_dynamodb"></a> [dynamodb](#module\_dynamodb) | ./dynamodb | n/a |
| <a name="module_lambda"></a> [lambda](#module\_lambda) | ./lambda | n/a |
| <a name="module_oidc"></a> [oidc](#module\_oidc) | ./oidc | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [terraform_data.exec](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | Describes the environment | `string` | n/a | yes |
| <a name="input_private_subnet_cidr"></a> [private\_subnet\_cidr](#input\_private\_subnet\_cidr) | Desribes the private subnet CIDR blocks | `list(string)` | n/a | yes |
| <a name="input_public_subnet_cidr"></a> [public\_subnet\_cidr](#input\_public\_subnet\_cidr) | Desribes the public subnet CIDR blocks | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Describes the region | `string` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR block range | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | Desribes the availability zones | `list(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->