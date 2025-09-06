# Infrastructure

This directory contains Infrastructure as Code (IaC) for the DanaVerse platform.

## Structure

```
infra/
├── environments/
│   ├── staging/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── production/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── modules/
│   ├── database/
│   ├── api/
│   ├── web/
│   └── monitoring/
└── scripts/
    ├── deploy.sh
    └── destroy.sh
```

## Prerequisites

- Terraform >= 1.0
- AWS CLI configured
- Docker (for local development)

## Usage

### Staging Deployment

```bash
cd environments/staging
terraform init
terraform plan
terraform apply
```

### Production Deployment

```bash
cd environments/production
terraform init
terraform plan
terraform apply
```

## Security

- All secrets are managed through AWS Secrets Manager
- IAM roles follow least privilege principle
- VPC with private subnets for database
- WAF rules for API protection

## Monitoring

- CloudWatch for logs and metrics
- AWS X-Ray for distributed tracing
- SNS for alerting
- Custom dashboards in CloudWatch
