resource "aws_vpc" "environment" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags {
        Name = "terraform-aws-vpc-1"l
    }   
}

resource "aws_subnet" "subnet1" {
    cidr_block = "${cidrsubnet(aws_vpc.environment-1.cidr_block, 3, 1)}"        #CIDR Block function for VPC
    vpc_id = "${aws_vpc.environment-1.id}"
    availability_zone = "us-east-1a"
}

resource "aws_subnet" "subnet2" {
    cidr_block = "${cidrsubnet(aws_vpc.environment-1.cidr_block, 2, 2)}"
    vpc_id = "${aws_vpc.environment-1.id}"
    availability_zone = "us-east-1b"
}

resource "aws_security_group" "subnetsecurity" {
    vpc_id = "${aws_vpc.environment-1.id}"

    ingress {
        cidr_blocks = [
            "${aws_vpc.environment-1.cidr_block}"       #Used CIDR block variable assigned in line 2.
        ]

        from_port = 80
        to_port = 80
        protocol = "tcp"
    }  
}
