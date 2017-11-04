resource "aws_instance" "mnadol" {
	ami	= "${lookup(var.AMIS, var.AWS_REGION)}"
	instance_type = "t2.micro"
	tags {
		Name = "mnadol-TR-instance"
	}
  
	#VPC
	subnet_id = "${aws_subnet.mnadol-public-1.id}"

	#security group
	vpc_security_group_ids = ["${aws_security_group.mnadol-allow-ssh.id}"]

	#public key
	key_name = "${aws_key_pair.mnadolkey.key_name}"
	provisioner "local-exec" {
		command ="echo ${aws_instance.mnadol.private_ip} >> private_ips.txt"
}
	provisioner "local-exec" {
		command ="echo ${aws_instance.mnadol.public_ip} >> public_ips.txt"
}
	#userdata
	user_data = "${data.template_cloudinit_config.cloudinit-example.rendered}"
}

output "ip" {
	value = "${aws_instance.mnadol.public_ip}"
}
