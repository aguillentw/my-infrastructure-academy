terraform {
  backend "s3" {
    bucket         = "abel-terraform-state-160071257600"
    key            = "terraform/01.terraform.tfstate"
    #dynamodb_table = "s3backend" # LockID configuration
    region         = "eu-west-1"
  }
}