terraform {
  backend "s3" {
    bucket = "simpletimeservice-tf-state"
    key = "ecs/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}