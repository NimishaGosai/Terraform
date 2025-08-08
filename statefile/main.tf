
# Create IAM Role for EC2
resource "aws_iam_role" "ec2_s3_full" {
  name = "EC2S3FullAccessRole"

  assume_role_policy = jsonencode({
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach AmazonS3FullAccess policy to the role
resource "aws_iam_role_policy_attachment" "s3_full_access" {
  role       = aws_iam_role.ec2_s3_full.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# Create Instance Profile (needed for EC2 to use the role)
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "EC2S3FullAccessProfile"
  role = aws_iam_role.ec2_s3_full.name
}

# 4. Create EC2 Instance with the IAM Role
resource "aws_instance" "dev" {
  ami = "ami-08a6efd148b1f7504"
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  tags ={
    Name="ec2WithS3FullAccess"
  }
}