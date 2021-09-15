provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
}

provider "archive" {}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda.py"
  output_path = "lambda.zip"
}

# Referenced from official documentation and youtube (https://youtu.be/Lkm3v7UDlD8)
data "aws_iam_policy_document" "policy" {
  statement {
    sid    = ""
    effect = "Allow"

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "tf_lambda_role" {
  name               = "tf_lambda_role"
  assume_role_policy = data.aws_iam_policy_document.policy.json
}

resource "aws_lambda_function" "tffunction" {
  filename      = "lambda.zip"
  function_name = "lambda"
  role          = aws_iam_role.tf_lambda_role.arn
  handler       = "lambda.greeting"
  runtime = "python3.8"
}