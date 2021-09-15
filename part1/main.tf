provider "aws" {
  region = "us-east-1"
  profile = "udacity"
}

# EC2 Instances
resource "aws_instance" "T2" {
  count = 4
  ami = "ami-087c17d1fe0178315"
  instance_type = "t2.micro"
  tags = {
    "Name" = "Udacity T2"
  }
}


resource "aws_instance" "M4" {
  count = 2
  ami = "ami-087c17d1fe0178315"
  instance_type = "m4.large"
  tags = {
    "Name" = "Udacity M4"
  }
}