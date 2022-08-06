data "aws_ecr_repository" "main" {
  name = "timeoff-ecr-repo"
}

# output "aws_ecr_repository_url" {
#   value = aws_ecr_repository.main.repository_url
# }
