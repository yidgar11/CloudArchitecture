output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.default.endpoint
}