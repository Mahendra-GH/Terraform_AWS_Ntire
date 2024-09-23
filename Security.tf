#Creating web Security Group
resource "aws_security_group" "web" {
  vpc_id = aws_vpc.base.id
  name   = var.web_security_group.name
  tags = {
    Name = var.web_security_group.name
  }


}
resource "aws_vpc_security_group_ingress_rule" "web" {
  count             = length(var.web_security_group.ingress)
  security_group_id = aws_security_group.web.id
  ip_protocol       = var.web_security_group.ingress[count.index].protocol
  cidr_ipv4         = var.web_security_group.ingress[count.index].source
  from_port         = var.web_security_group.ingress[count.index].port
  to_port           = var.web_security_group.ingress[count.index].port
  description       = var.web_security_group.ingress[count.index].description
  depends_on        = [aws_security_group.web]
  tags = {
    Name = var.web_security_group.ingress[count.index].name
  }

}
resource "aws_vpc_security_group_egress_rule" "web" {
  security_group_id = aws_security_group.web.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  depends_on        = [aws_security_group.web]
}


#Creating app security group

resource "aws_security_group" "app" {

  vpc_id = aws_vpc.base.id
  tags = {
    Name = var.App_security_group.name
  }
}

resource "aws_vpc_security_group_ingress_rule" "App" {
  count             = length(var.App_security_group.ingress)
  security_group_id = aws_security_group.app.id
  ip_protocol       = var.App_security_group.ingress[count.index].protocol
  cidr_ipv4         = var.App_security_group.ingress[count.index].source
  from_port         = var.App_security_group.ingress[count.index].port
  to_port           = var.App_security_group.ingress[count.index].port
  description       = var.App_security_group.ingress[count.index].description
  depends_on        = [aws_security_group.app]
  tags = {
    Name = var.App_security_group.ingress[count.index].name
  }
}

resource "aws_vpc_security_group_egress_rule" "app" {
  security_group_id = aws_security_group.app.id
  ip_protocol       = "-1"
  cidr_ipv4         = "172.16.0.0/16"
  depends_on        = [aws_security_group.app]

}

#create Db security group
resource "aws_security_group" "Db" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "Db"
  }

}

resource "aws_vpc_security_group_ingress_rule" "Db" {
  count            = length(var.Db_security_group.ingress)
  security_group_id = aws_security_group.Db.id
  ip_protocol       = var.Db_security_group.ingress[count.index].protocol
  cidr_ipv4         = var.Db_security_group.ingress[count.index].source
  from_port         = var.Db_security_group.ingress[count.index].port
  to_port           = var.Db_security_group.ingress[count.index].port
  description       = var.Db_security_group.ingress[count.index].description
  depends_on        = [aws_security_group.Db]
  tags = {
    Name = var.Db_security_group.ingress[count.index].name
  }
}

resource "aws_vpc_security_group_egress_rule" "Db" {
  security_group_id = aws_security_group.Db.id
  ip_protocol       = "-1"
  cidr_ipv4         = "172.16.0.0/16"
 # depends_on        = [aws_security_group.Db]
  
}




