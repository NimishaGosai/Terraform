terraform {
  backend "s3" {
    bucket = "terraformdir"
    key    = "terrafrom.tfstate"
    region = "us-east-1"
  }
}
