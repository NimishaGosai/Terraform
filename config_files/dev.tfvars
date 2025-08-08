ami-id="ami-08a6efd148b1f7504"
instance-type = "t2.micro"


# Note* - We can use var files for different environent like dev,sit,uat,prod instead of terrafrom.tfvars
# In above scenario, we need to use  command terraform apply -var-file="dev.tfvars". i.e. excplicitely need to mention the name of var file

