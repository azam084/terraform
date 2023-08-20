# create security group for the EC2 instance

#data "aws_vpc" "selected" {
 # id = module.vpc.aws_vpc.vpc.id
#}


resource "aws_security_group" "ec2_sg" {
    description = "Security Group for EC2 Instance"
    vpc_id = aws_vpc.vpc.id
    #vpc_id = module.vpc.aws_vpc.vpc.id
    #vpc_id = "${vpc.aws_vpc.vpc.id}"
    #vpc_id = var.vpc_id
    #vpc_id = "${aws_vpc.vpc.id}"
    #vpc_id = data.aws_vpc.selected.id
    #vpc_id = ["${module.vpc.aws_vpc.vpc.id}"]

    ingress {
        description         = "HTTP Access"
        from_port           = 80
        to_port             = 80
        protocol            = "tcp"
        cidr_blocks         = [var.ingress_cidr_blocks]
    }

    ingress {
      cidr_blocks           = [var.ingress_cidr_blocks]
      description           = "HTTPS Access"
      from_port             = 443
      protocol              = "tcp"
      to_port               = 443
    }

    egress {
      cidr_blocks           = [var.egress_cidr_blocks]
      description           = "Outbout HTTP Ports"
      from_port             = 80
      protocol              = "tcp"
      to_port               = 80
    } 

    egress {
      cidr_blocks           = [var.egress_cidr_blocks]
      description           = "Outbout HTTPS Ports"
      from_port             = 443
      protocol              = "tcp"
      to_port               = 443
    } 

    tags = {
      Name = var.sg_name
    }
}

