##Creating an Vpc
resource "aws_vpc" "base" {
  cidr_block           = var.Vpc_info.cidr_block
  enable_dns_hostnames = var.Vpc_info.enable_dns_hostnames

  tags = {
    Name = var.Vpc_info.name
  }

}

#Creating a 2public subnets
resource "aws_subnet" "public" {
  count             = length(var.Subnet_Public)
  vpc_id            = aws_vpc.base.id
  cidr_block        = var.Subnet_Public[count.index].subnet_cidr_block
  availability_zone = var.Subnet_Public[count.index].subnet_az
  depends_on        = [aws_vpc.base]
  tags = {
    Name = var.Subnet_Public[count.index].name
  }

}
#Creating a 4private subnets
resource "aws_subnet" "private" {
  count             = length(var.Subnet_Private)
  vpc_id            = aws_vpc.base.id
  cidr_block        = var.Subnet_Private[count.index].subnet_cidr_block
  availability_zone = var.Subnet_Private[count.index].subnet_az
  depends_on        = [aws_vpc.base]
  tags = {
    Name = var.Subnet_Private[count.index].name
  }
}

#Create one public route table
resource "aws_route_table" "public" {
  count      = length(var.Subnet_Public) > 0 ? 1 : 0
  vpc_id     = aws_vpc.base.id
  depends_on = [aws_vpc.base]
  tags = {
    Name = "public_RT"
  }

}
#Associate public rt with public subnets(web-1,web-2)
resource "aws_route_table_association" "public" {
  count          = length(var.Subnet_Public)
  route_table_id = aws_route_table.public[0].id
  subnet_id      = aws_subnet.public[count.index].id
  depends_on     = [aws_route_table.public, aws_subnet.public]

}

#create private route table
resource "aws_route_table" "Private" {
  count      = length(var.Subnet_Private) > 0 ? 1 : 0
  vpc_id     = aws_vpc.base.id
  depends_on = [aws_vpc.base]
  tags = {
    Name = "private_RT"
  }

}
#Now 4private subnets associate with private routetable(app1,app2,db1,db2)
resource "aws_route_table_association" "private" {
  count          = length(var.Subnet_Private)
  route_table_id = aws_route_table.Private[0].id
  subnet_id      = aws_subnet.private[count.index].id
  depends_on     = [aws_route_table.Private, aws_subnet.private]

}

#Creating Internet gateWay
resource "aws_internet_gateway" "ntire" {

  vpc_id     = aws_vpc.base.id
  depends_on = [aws_vpc.base]
  tags = {
    Name = "ntire_igw"
  }

}

#Adding rotes for Public Route Table

resource "aws_route" "to_access_internet" {
  count                  = length(var.Subnet_Public) > 0 ? 1 : 0
  route_table_id         = aws_route_table.public[count.index].id
  gateway_id             = aws_internet_gateway.ntire.id
  destination_cidr_block = "0.0.0.0/0"


}

#Create An Ec2 Instance

resource "aws_instance" "base_web" {
  subnet_id = aws_subnet.public[0].id
  vpc_security_group_ids = [ aws_security_group.web.id ]
  ami = "ami-0c2af51e265bd5e0e"
  instance_type = "t2.micro"
  key_name = "my_rsa_pub"
  associate_public_ip_address = true

  
}

