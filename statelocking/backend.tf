terraform {
  backend "s3" {
    bucket = "terraformdir"
    key    = "statelocking/terrafrom.tfstate"
    region = "us-east-1"
    #use_lockfile = true-  S3 support this feature for specific terraform version. i.e vversion > 1.10 
    dynamodb_table = "terraform_state_locking" # This can be used with any terraform version
    encrypt = true

    #Note* : Can achieve lock on state file with either use_lockfile or dynamoDB. Use S3 as no extra resource and cheaper compare to DynamoDB
    # Here, terraform_state_locking is the table name. Must create partition ker with name "LockID".
  }
}
