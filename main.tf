provider "aws" {
    region = "us-east-2"
}

//Ec2 _insrtance 
resource "aws_instance" "demo" {
    ami           = "ami-0cb91c7de36eed2cb"
    instance_type = "t2.large"
    key_name = "swiggy-project.pem"
    vpc_security_group_ids  = [aws_security_group.swiggy_sg.id]  

    tags = {
        Name = "Swiggy_Deploy"
    }
    
 root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }
}

//Security Group
resource "aws_security_group" "swiggy_sg" {
    name        = "swiggy_sg"
    description = "Allow inbound traffic"
    vpc_id      = "vpc-016507a7df050d7a1"

    ingress {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 8080
        to_port   = 8080
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 3000
        to_port   = 3000
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 9000
        to_port   = 9000
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port   = 0
        protocol  = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


