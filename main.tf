provider "aws" {
    region = "us-east-2"
}

//Ec2 _insrtance 
resource "aws_instance" "demo" {
    ami           = "ami-0cb91c7de36eed2cb"
    instance_type = "t2.large"
    key_name = "swiggy-key"
    vpc_security_group_ids  = [aws_security_group.swiggy_app.id]  

    tags = {
        Name = "Swiggy_Deploy"
    }
    
 root_block_device {
    volume_size = 30
    volume_type = "gp2"
}
    user_data = file("resouce.sh")

}

//Security Group
resource "aws_security_group" "swiggy_app" {
    name        = "swiggy_app"
    description = "Allow inbound traffic"
    vpc_id      = "vpc-0825751e1891f5529"

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

resource "aws_key_pair" "deployer" {
  key_name   = "swiggy-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC66oxyETMXIfRqoOJgrP01WgkHnAkG78i52oy+6AJudFNxj4w4bBGRcFBM8rX+pm6TvN7f35AbaBpUjxNk6hx2FQBHkzmPEvKzWkTGfKDjF45DtgQcIBk8Yy4jC37IqttgO1a1xAJ6oL+LUSDx7WiwMxNw3JOOOxlA9E/+TX3YGqUhLxhe3olZKvcpSUdNXGcJjr5Je/khpUU/47Wx8FqoC0WPZW//qVnaa+yXzKkFAuXmiFI6esMSVuE/UeUCXlnoQXzRHrs/jnZUPGRZ/KU+EF9L0JIAGi2NtLuCf8HV/DKgnOeoEiBUgYwQKwGHlVl7qSiOx5lgY1R5N0B1tPAN root@vansh-terraform"
 }

