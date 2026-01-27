provider "aws" {
  region = "eu-north-1"
}

module "my_ec2" {
  source = "./modules/ec2"

  ami           = "ami-0683ee28af6610487"
  instance_type = "t3.micro"
  name          = "simple-ec2"
}
