resource "aws_key_pair" "deploy" {
  key_name   = "ansible-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCrmv84WT8F1OmccBQB/MKfY+4Ddv5QKN7+1S7NVqKXcl/x+qUf1JrxgDzUY8nkSgN4KUyR5QL3H/1J1iUc/p1Vyf8pJa4ONoTxM98FekgUKtUK7CK3uhXbe+tKF+OCk5g8rUAfhyTalamYd20i7nYc91/KQ/wF1iGSnumuX1bfn55jN1eS2qb6qxtDf98dJmWXVyvZ1ock9zivCtQXoDoi8X2CVlVv6jTtoId8/ABCoLzOZ2vBqVp51olg+dtrjEMaCie7tTZBYe3Ve3pm2YZK2kW8sl5liDaShHRqm2pePqsSmZi/1GSWp2sTNBvnzMdhr4RBvzlicUtv0AsiPH8ZSdA6bTbA0gHi3ktb1wzqwE1PUo8oExLF6HcrR4P1iTyRsNf2FWIEm/1BPEvLJpfHpBT2fkA5r0xlgU7MP7WsMwwQalg9ynwnNCJU8iY/6+plT8GJ2tCS9rYkcFMAp0td4p3euOglugmwURhNy1hkE5Rct9ezbcEv4lfv5p+h/KdkMzi2BLV1UCv9raJSl17h1neOj+YhsLZ0GtDRNDRvM64M8jb09AaxNvdzb6Z7vAGBZKDK3Rjc4y+V7Fm5y03o/Pz3uBA1V4YZh64dae6lYWZXCZ8Hem8mU0h2LD5Mgeeqm2LTE1XSgVbMrnaxywgEE73eK1Q5YAV4PZx5p+4ksw== hitesh@M1033NDP1408.local"
}
resource "aws_security_group" "sg1" {
  name        = "sre-hitesh"
  description = "hitesh_test_SG"
  vpc_id      = "vpc-018a7b2f2a0ee4a10"

}

# Create a new instance of the latest Ubuntu 14.04 on an
# t2.micro node with an AWS Tag naming it "HelloWorld"
provider "aws" {
  region = "ap-northeast-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "Controll-Server" {
  ami             = "${data.aws_ami.ubuntu.id}"
  instance_type   = "t2.micro"
  key_name        = "${aws_key_pair.deploy.key_name}"
  security_groups = ["${aws_security_group.sg1.id}"]
  subnet_id       = "subnet-0ad1f0160e704c1c4"


  tags = {
    Name = "Controll-Server"
  }
}