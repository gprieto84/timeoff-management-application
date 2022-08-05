resource "aws_ecr_repository" "timeoff_ecr_repo" {
  name = "timeoff-ecr-repo-${var.env}" # Naming my repository
}
