variable "bucket" {
  description = "AWS S3 Bucket name for Terraform state"
}
variable "dynamodb_table" {
  description = "AWS DynamoDB table for state locking"
}

variable "key" {
  description = "AWS S3 Bucket key for Terraform state"
}

variable "region" {
  description = "AWS region in which to operate"
}

variable "cost_mgr" {
  description = "Value for mgr cost tag"
  default     = ""
}

variable "env" {
  description = "Environment tag, such as 'dev', 'prod', etc."
  default     = "dev"
}
