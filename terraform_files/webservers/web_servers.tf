provider "aws" {
  region = "ap-northeast-1"
}

variable "key_name" {
  default = "ansible-key"
}

variable "subnet_id" {
  default = "subnet-0ad1f0160e704c1c4"
}


variable "instance_count" {
  default = "2"
}
data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn2-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

resource "aws_instance" "web-servers" {
  ami             = data.aws_ami.amazon_linux.id
  instance_type   = "t2.micro"
  count           = "${var.instance_count}"
  key_name        = var.key_name
  security_groups = ["sg-0bd137a3f52df105a"]
  subnet_id       = var.subnet_id


  tags = {
    Name  = "webserver-${count.index + 1}"
    Batch = "web"
  }
}