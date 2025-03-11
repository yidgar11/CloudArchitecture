resource "aws_instance" "example" {
  count = 2
  dynamic "region_name" {
    for_each = {
      "region1" = "us-east-1"
      "region2" = "us-west-2"
    }
    content {
      region = region.value
      instance_type = "t2.micro"
      ami           = "ami-04b4f1a9cf54c11d0"
    }
  }
}

#see the solution in the presentation!