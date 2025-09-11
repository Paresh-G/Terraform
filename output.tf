output "aws_s3_bucket_id" {
  value = aws_s3_bucket.aws_s3_bucket_block.id
}

output "aws_s3_bucket_arn" {
  value = aws_s3_bucket.aws_s3_bucket_block.arn
}

output "aws_vpc_id" {
  value = aws_vpc.aws_vpc_block.id
}

output "aws_vpc_arn" {
  value = aws_vpc.aws_vpc_block.arn
}

output "aws_vpc_owner_id" {
  value = aws_vpc.aws_vpc_block.owner_id
}