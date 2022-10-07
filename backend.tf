terraform {
  backend "s3" {
    bucket         = "ta-terraform-tfstates-839895325100"
    key            = "lab/training-asg/terraform.tfstates"
    dynamodb_table = "terraform-lock"
  }
}