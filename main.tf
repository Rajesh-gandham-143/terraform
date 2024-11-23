resource "aws_vpc" "login_vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"

    tags = {
        name = "login_vpc"
    }
}

resource "aws_subnet" "login_fe_subnet" {
    vpc_id = aws_vpc.login_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-southeast-2a"
    map_public_ip_on_launch = "true"

    tags = {
        name = "login_frontend_subnet"
    }
}

resource "aws_subnet" "login_be_subnet" {
    vpc_id = aws_vpc.login_vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-southeast-2b"
    map_public_ip_on_launch = "true"

    tags = {
        name = "login_backend_subnet"
    }
}

resource "aws_subnet" "login_db_subnet" {
    vpc_id = aws_vpc.login_vpc.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "ap-southeast-2c"
    map_public_ip_on_launch = "false"

    tags = {
        name = "login_database_subnet"
    }
}

resource "aws_internet_gateway" "login_igw" {
    vpc_id = aws_vpc.login_vpc.id

    tags = {
        name = "login_internet_gateway"
    }
}

resource "aws_route_table" "public_rwt_table" {
    vpc_id = aws_vpc.login_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.login_igw.id
    }

    tags = {
        name = "public_route_table"
    }
}

resource "aws_route_table" "private_rwt_table" {
    vpc_id = aws_vpc.login_vpc.id

    tags = {
        name = "private_route_table"
    }
}

resource "aws_route_table_association" "login_web_asc" {
    subnet_id = aws_subnet.login_fe_subnet.id
    route_table_id = aws_route_table.public_rwt_table.id
}
resource "aws_route_table_association" "login_api_asc" {
    subnet_id = aws_subnet.login_be_subnet.id
    route_table_id = aws_route_table.public_rwt_table.id
}

resource "aws_route_table_association" "login_db_asc" {
    subnet_id = aws_subnet.login_db_subnet.id
    route_table_id = aws_route_table.private_rwt_table.id
}
