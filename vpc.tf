#VPC settings
# Internet VPC
resource "aws_vpc" "mnadol-VPC" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags {
        Name = "mnadol-VPC"
    }
}


# Subnets
resource "aws_subnet" "mnadol-public-1" {
    vpc_id = "${aws_vpc.mnadol-VPC.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"

    tags {
        Name = "mnadol-public-1"
    }
}

resource "aws_subnet" "mnadol-private-1" {
    vpc_id = "${aws_vpc.mnadol-VPC.id}"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1b"

    tags {
        Name = "mnadol-private-1"
    }
}

# Internet GW
resource "aws_internet_gateway" "mnadol-VPC-gw" {
    vpc_id = "${aws_vpc.mnadol-VPC.id}"

    tags {
        Name = "mnadol-GW"
    }
}

# route tables
resource "aws_route_table" "mnadol-public" {
    vpc_id = "${aws_vpc.mnadol-VPC.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.mnadol-VPC-gw.id}"
    }

    tags {
        Name = "mnadol-public-1"
    }
}

# route associations public
resource "aws_route_table_association" "mnadol-public-1" {
    subnet_id = "${aws_subnet.mnadol-public-1.id}"
    route_table_id = "${aws_route_table.mnadol-public.id}"
}
