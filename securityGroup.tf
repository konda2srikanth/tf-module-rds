# This DB has to be access only by default vpc and by the workloads running on eks
resource "aws_security_group" "main" {
  name        = "${var.env}-rds-sg"
  description = "${var.env}-rds-sg"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allows RDP"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.eks_subnet_cidr
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
