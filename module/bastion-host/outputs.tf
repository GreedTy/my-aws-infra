output "instance_id" {
  description = "Bastion EC2 instance ID"
  value       = aws_instance.bastion.id
}

output "bastion_sg_id" {
  description = "Bastion에 접속하는 SG ID"
  value       = [aws_security_group.bastion.id]
}

output "eip_id" {
  description = "Bastion에 할당된 EIP ID"
  value       = [aws_eip.bastion.id]
}