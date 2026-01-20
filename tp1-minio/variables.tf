variable "minio_server" {
  description = "MinIO server adress"
  type        = string
  default     = "127.0.0.1:9000"
}

variable "minio_user" {
  description = "MinIO administrator name"
  type        = string
  sensitive   = true
}

variable "minio_password" {
  description = "MinIO adiminstrator password"
  type        = string
  sensitive   = true
}