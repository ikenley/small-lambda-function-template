# ------------------------------------------------------------------------------
# Create the core VPC network infrastructure
# ------------------------------------------------------------------------------

locals {
  namespace = "ik"
  env       = "dev"
  is_prod   = false
}

terraform {
  required_version = ">= 0.14"

  backend "s3" {
    profile = "terraform-dev"
    region  = "us-east-1"
    bucket  = "924586450630-terraform-state"
    key     = "s3-notify-function/terraform.tfstate"
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "terraform-dev"
}

data "aws_ssm_parameter" "s3_bucket_trigger_name" {
  name = "/ik/dev/core/data_lake_s3_bucket_name"
}

module "s3_notify_function" {
  source = "../../../modules/s3_notify_function"

  namespace = local.namespace
  env       = local.env
  is_prod   = local.is_prod

  s3_bucket_trigger_name = data.aws_ssm_parameter.s3_bucket_trigger_name.value

  tags = {}
}
