resource "aws_instance" "instance1" {
    ami = "ami-083644ad45483a44f"
    isntance_type = "t2.micro"
    tags = {
        name = "server1"
    }
}