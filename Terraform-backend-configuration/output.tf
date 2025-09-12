output "vpc_arn" {
  value = aws_vpc.aws_vpc_block.arn
}

output "vpc_id" {
  value = aws_vpc.aws_vpc_block.id
}

output "aws_subnet_arn" {
  value = aws_subnet.aws_subnet_block.arn
}

output "aws_subnet_id" {
  value = aws_subnet.aws_subnet_block.id
}