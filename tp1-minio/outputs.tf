output "minio_website_url" {
  description = "url of static website"
  value       = "http://${var.minio_server}/${minio_s3_bucket.web_bucket.bucket}/index.html"
}

output "bucket_name" {
  value = minio_s3_bucket.web_bucket.bucket
}