# Lambda to start / stop RDS instances - only to be used during development

data "aws_iam_policy_document" "lambda" {
  statement {
    effect = "Allow"

    actions = [
      "rds:StartDBCluster",
      "rds:StopDBCluster",
      "rds:ListTagsForResource",
      "rds:DescribeDBInstances",
      "rds:StopDBInstance",
      "rds:DescribeDBClusters",
      "rds:StartDBInstance"
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "lambda_assumerole" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "lambda" {
  description           = "Lambda IAM role"
  assume_role_policy    = data.aws_iam_policy_document.lambda_assumerole.json
  force_detach_policies = true
}

resource "aws_iam_policy" "stop_start_rds" {
  name        = "lambda-stop-start-rds"
  path        = "/"
  description = "Policy to allow lambda to stop/start RDS instances."
  policy      = data.aws_iam_policy_document.lambda.json
}

resource "aws_iam_role_policy_attachment" "stop_start_rds" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.stop_start_rds.arn
}

resource "aws_iam_role_policy_attachment" "lambda" {
  role       = aws_iam_role.terraform_function_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "start_rds" {
  function_name = "start_rds"
  role          = aws_iam_role.lambda.arn
  package_type  = "Zip"
  handler       = "start_rds.lambda_handler"
  runtime       = "python3.13"

  filename         = "start_rds.zip"
  source_code_hash = filebase64sha256("start_rds.zip")

  depends_on = [
    aws_iam_role.lambda
  ]
}

resource "aws_lambda_function" "stop_rds" {
  function_name = "stop_rds"
  role          = aws_iam_role.lambda.arn
  package_type  = "Zip"
  handler       = "stop_rds.lambda_handler"
  runtime       = "python3.13"

  filename         = "stop_rds.zip"
  source_code_hash = filebase64sha256("stop_rds.zip")

  depends_on = [
    aws_iam_role.lambda
  ]
}