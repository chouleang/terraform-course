locals {
  tags = merge(
    var.tags,
    {
      Environment = var.environment
      Project     = "Terraform-Course"
    }
  )
  test = "test"
}