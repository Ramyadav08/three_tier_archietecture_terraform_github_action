resource "aws_s3_bucket" "mybucket" {
  count=length(var.bucket_names) 
  bucket = var.bucket_names[count.index] 

  tags = {
    Name        = "My S3 Bucket"
  }
}


resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.mybucket.id
  acl    = "private"
}

resource "null_resource" "upload_folder" {
  provisioner "local-exec" {
    command = "aws s3 cp ./application-code/  s3://${aws_s3_bucket.mybucket[0].bucket} --recursive"
  }

  depends_on = [aws_s3_bucket.mybucket]
}
