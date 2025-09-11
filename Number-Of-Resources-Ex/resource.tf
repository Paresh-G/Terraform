
// aws vpc creation basic resource block (only creating vpc)
resource "aws_vpc" "aws_vpc_block" {
  count = 3
  cidr_block = var.vpc_cidr_ranges[count.index] //refering .tfvar file for multiple resources to create with default index ranges like 0,1,2 etc.
  instance_tenancy = var.vpc_instance_tenancy
  tags = {
    "Name"  =  "my-test-vpc"
    "env"   =  "Dev"
  }
}
