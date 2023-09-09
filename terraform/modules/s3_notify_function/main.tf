
# ------------------------------------------------------------------------------
# Creates the DNS record and S3 redirect bucket
# ------------------------------------------------------------------------------

locals {
  base_prefix   = [var.namespace, var.env, "s3-notify-function"]
  prefix        = join("-", local.base_prefix)
  output_prefix = join("/", local.base_prefix)

  tags = merge(var.tags, {
    Terraform   = true
    Environment = var.env
    is_prod     = var.is_prod
    repo        = "https://github.com/ikenley/small-lambda-function-template"
  })
}

data "aws_s3_bucket" "lambda_trigger" {
  bucket = var.s3_bucket_trigger_name
}

module "lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.0.2"

  function_name = local.prefix
  description   = "Send SNS notifications on S3 events"
  handler       = "index.handler"
  runtime       = "nodejs18.x"

  source_path = {
    path             = "${path.module}/../../../s3-notify-function/dist/src"
    npm_requirements = false
  }

  tags = local.tags
}


resource "aws_s3_bucket_notification" "lambda_trigger" {
  bucket = data.aws_s3_bucket.lambda_trigger.id

  lambda_function {
    lambda_function_arn = module.lambda.lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
    # filter_prefix       = "file-prefix"
    # filter_suffix       = "file-extension"
  }
}

resource "aws_lambda_permission" "lambda_trigger" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.lambda_function_name
  principal     = "s3.amazonaws.com"
  source_arn    = data.aws_s3_bucket.lambda_trigger.arn
}
