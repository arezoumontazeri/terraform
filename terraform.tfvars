Staging_Instnace = {
  "stage-db" = {
    Ami           = "ami-0683ee28af6610487"
    instance_type = "t3.micro"
    key           = "key3"
  }
  "stage-web1" = {
    Ami           = "ami-0683ee28af6610487"
    instance_type = "t3.micro"
    key           = "key1"
  }
  "stage-web2" = {
    Ami           = "ami-0683ee28af6610487"
    instance_type = "t3.micro"
    key           = "key2"
  }
}
product_instance = ["prod-web1", "prod-web2", "prod-db"]
ami              = "ami-0683ee28af6610487"
instance_type    = "t3.micro"
key_name         = "key3"