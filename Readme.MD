# Terraform

- Network
  - VPC (Public Subnet, Private Subnet)
  - Route53
  - Cloudfront
  - ELB
- Infra
  - EKS
  - Bastion-Host
- Database & Storage
  - Aurora RDS
  - S3

환경세팅 (Mac OS 기준) [CLI Download](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
```
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
brew update
brew upgrade hashicorp/tap/terraform
설치확인 : terraform -help
```

실행명령어
```
terraform init
terraform plan
terraform apply
```

AWS Terraform 관련 링크
- [Terraform Registry AWS Doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform AWS Module GitHub](https://github.com/hashicorp/terraform-provider-aws)