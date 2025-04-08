terraform { 
  required_providers { 
    aws = { 
      source   = "hashicorp/aws" 
      version = "~> 4.16" 
    } 
  } 

  required_version  = ">= 1.2.0" 
} 

provider  "aws" { 
  region   = "us-east-1" 
} 

resource "aws_dynamodb_table" "parameters" {
    name = "parameters"
    billing_mode = "PROVISIONED"
    read_capacity = 20
    write_capacity = 20
    hash_key = "fiid"
    range_key = "type"

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
      enabled = false
    }

    tags = {
      name = "dynamodb-table-parameters"
      environment = "dev"
    }
}

