resource "aws_instance" "instance1" {
    ami = "ami-001f2488b35ca8aad"
    instance_type = "t2.micro"
    tags = {
        name = "server1"
    }
}