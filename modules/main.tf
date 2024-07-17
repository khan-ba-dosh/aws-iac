resource "aws_instance" "vm" {
  for_each            = var.instances
  ami                 = each.value.ami
  instance_type       = each.value.instance_type
  key_name            = each.value.key_name
  subnet_id           = var.subnet_id
  #vpc_security_group_ids = [aws_security_group.main.id]
  tags = {
    Name = "${each.key}"
  }
