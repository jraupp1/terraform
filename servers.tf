data "aws_ami" "ubuntu" {
    most_recent = true       # Use the most recent available AMI

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"]
}

resource "aws_instance" "secondserver" {         # Assign the result to the AMI property of the instance
    ami = "${data.aws_ami.ubuntu.id}"
    instance_type = "t2.micro"            # AWS Free Tier Instance

    tags {
        Name = "identifiertag"
    }

    subnet_id = "${aws_subnet.subnet2.id}"
}
