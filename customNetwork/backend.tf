terraform {
  backend "s3" {
    bucket = "terraformdir"
    key    = "customNetwork/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
    
  }
}
