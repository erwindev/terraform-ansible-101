/*
Amazon Web Services
*/
provider "aws" {
  region = "us-east-1"
}

/* 
Key Pair
*/
resource "aws_key_pair" "key" {
  key_name   = "test_key"
  public_key = "${file("dev_key.pub")}"
}

/*
VPC Configuration
*/
resource "aws_vpc" "sample" {
    cidr_block = "192.168.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags {
        Name = "sample vpc"
    }
}


/*
Internet Gateway Configuration
*/
resource "aws_internet_gateway" "sample" {
   vpc_id = "${aws_vpc.sample.id}"
   tags {
       Name = "sample ig"
   }
}

/*
Subnet Configuration
*/
resource "aws_subnet" "sample" {
   vpc_id = "${aws_vpc.sample.id}"
   cidr_block = "192.168.0.1/24"
   availability_zone = "us-east-1a"
   tags {
       Name = "sample subnet"
   }
}

/*
Route Table Configuration
*/
resource "aws_route_table" "sample" {
   vpc_id = "${aws_vpc.sample.id}"
   route {
       cidr_block = "0.0.0.0/0"
       gateway_id = "${aws_internet_gateway.sample.id}"
   }
   tags {
       Name = "sample route"
   }
}

resource "aws_route_table_association" "sample_subnet_route_table" {
   subnet_id = "${aws_subnet.sample.id}"
   route_table_id = "${aws_route_table.sample.id}"
}

/*
Security Group Configuration
*/
resource "aws_security_group" "sample_ssh" {
   name = "SSH Security Group"
   description = "Allow SSH inbound"
   vpc_id = "${aws_vpc.sample.id}"
   ingress {
       from_port = 22
       to_port = 22
       protocol = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
   }
   egress {
       from_port = 0
       to_port = 0
       protocol = "-1"
       cidr_blocks = ["0.0.0.0/0"]
   }
   tags {
       Name = "sample_ssh_security_group"
   }
}

/*
EC2 Instance Configuration
*/
resource "aws_instance" "example" {
  count = "1"
  ami = "ami-b374d5a5"
  instance_type = "t2.small"
  subnet_id = "${aws_subnet.sample.id}"
  vpc_security_group_ids = [
    "${aws_security_group.sample_ssh.id}"
  ]  
  user_data = "${file("${path.module}/files/user_data.sh")}"
  tags = {
    Name = "test-instance"
    Environment = "dev"
  }
  key_name = "test_key"
}

/*
Elastic IP Configuration Instance
*/
resource "aws_eip" "example_public_id" {
   instance = "${aws_instance.example.id}"
   vpc = true
}