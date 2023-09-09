resource "aws_eip" "nat-gw-ip" {
        tags = {
            Name = "NATEIP"
        }
}