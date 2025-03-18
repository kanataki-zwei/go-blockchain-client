resource "aws_vpc" "blockchain_vpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "blockchain_subnet" {
  vpc_id            = aws_vpc.blockchain_vpc.id
  cidr_block        = var.subnet_cidr
  availability_zone = "${var.aws_region}a"
}

resource "aws_security_group" "blockchain_sg" {
  vpc_id = aws_vpc.blockchain_vpc.id

  ingress {
    from_port   = var.container_port
    to_port     = var.container_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
