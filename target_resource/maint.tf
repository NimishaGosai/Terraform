resource "aws_instance" "name" {
  ami = "ami-08a6efd148b1f7504"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  tags = {
    Name = "dev_server"
  }
 }

resource "aws_s3_bucket" "dev_bucket"{
   bucket = "target-bucket-nimi"
}
  
# If need to create only s3 bucket and not instance then run below command
# terraform plan --target=aws_s3_bucket.dev_bucket
