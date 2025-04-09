terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_dynamodb_table" "parameters" {
  name           = "parameters"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "fiid"
  range_key      = "type"

  attribute {
    name = "fiid"
    type = "S"
  }

  attribute {
    name = "type"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  lifecycle {
    ignore_changes = [ttl]
  }

  tags = {
    name        = "dynamodb-table-parameters"
    environment = "dev"
  }
}


resource "aws_sqs_queue" "my_sqs" {
  name                       = "my-sqs"
  delay_seconds              = 0
  visibility_timeout_seconds = 30

  tags = {
    environment = "dev"
    Name        = "my-sqs"
  }
}

resource "aws_ssm_parameter" "entrypoint_sqs_queue_url" {
  name  = "/config/vdc-back-limits-p2p/entrypoint.sqs.queueUrl"
  type  = "String"
  value = "https://sqs.us-east-1.amazonaws.com/058264091195/my-sqs"

  tags = {
    Environment = "dev"
    Application = "mi-aplicacion"
  }
}


