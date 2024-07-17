resource "aws_instance" "macs-vm" {
    for_each               = var.instances
    ami                    = each.value.ami
    instance_type          = each.value.instance_type
    key_name               = each.value.key_name
    subnet_id              = var.subnet_id #aws_subnet.main.id
    #user_data              = "${file(${each.value.script})}"

    tags = {
      Name = "${each.key}"
    }
  }

  data "aws_kms_key" "ebs" {
    key_id  = "alias/disktpm2"
  }

  resource "aws_ebs_volume" "macs-vol" {
    for_each = var.volumes
    availability_zone = "${each.value.az}" #"us-west-2a"
    size              = each.value.size

   kms_key_id  = data.aws_kms_key.ebs.arn
   encrypted   = true

    tags = {
      Name = "EBS-${each.key}"
    }
  }

  resource "aws_volume_attachment" "ebs_att" {
    for_each    = var.attachments
    device_name = "${each.value.device_name}" #/dev/sdh
    volume_id   = aws_ebs_volume.macs-vol["${each.value.vol_name}"].id
    instance_id = aws_instance.macs-vm["${each.value.vm_name}"].id
    #force_detach = true
  }
