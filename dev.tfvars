Vpc_info = {
  name                 = "TerraformVpc"
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = true
}
Subnet_Public = [{
  name              = "web-1"
  subnet_cidr_block = "172.16.0.0/24"
  subnet_az         = "ap-south-1a"
  }, {
  name              = "web-1"
  subnet_cidr_block = "172.16.1.0/24"
  subnet_az         = "ap-south-1b"
}]
Subnet_Private = [{

  name              = "app-1"
  subnet_cidr_block = "172.16.2.0/24"
  subnet_az         = "ap-south-1a"
  }, {
  name              = "app-2"
  subnet_cidr_block = "172.16.3.0/24"
  subnet_az         = "ap-south-1b"
  }, {
  name              = "db-1"
  subnet_cidr_block = "172.16.4.0/24"
  subnet_az         = "ap-south-1b"
  }, {
  name              = "db-2"
  subnet_cidr_block = "172.16.5.0/24"
  subnet_az         = "ap-south-1c"
}]

web_security_group = {
  name = "web"
  ingress = [{
    name        = "Allow ssh"
    protocol    = "TCP",
    port        = 22,
    description = "Enable ssh",
    source      = "0.0.0.0/0"

    }, {
    name        = "Allow http"
    protocol    = "TCP",
    port        = 80,
    description = "Enable http",
    source      = "0.0.0.0/16"
    }, {
    name        = "Allow https"
    protocol    = "TCP",
    port        = 443,
    description = "Enable https",
    source      = "0.0.0.0/0"
  }]
}

App_security_group = {
  name = "App"
  ingress = [{
    name        = "AppIngress"
    port        = 8000,
    protocol    = "tcp",
    source      = "172.16.0.0/16",
    description = "Open 8000 port"
  }]
}

Db_security_group = {
  ingress = [ {
    name        = "DbIngress"
    port        = 3306,
    protocol    = "tcp",
    source      = "172.16.0.0/16",
    description = "Open 3306 port"
  } ]
}

