terraform {
  backend "s3" {
    bucket         = "aa-terraform-state-160071257600"
    key            = "terraform/aida-abel.tfstate"
    #dynamodb_table = "s3backend" # LockID configuration
    region         = "eu-west-1"
  }
}