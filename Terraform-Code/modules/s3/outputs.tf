output "bucket_ids" {
  value = aws_s3_bucket.mybucket[*].id
}

output "bucket_arns" {
  value = aws_s3_bucket.mybucket[*].arn
}
