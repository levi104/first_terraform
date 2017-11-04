resource "aws_key_pair" "mnadolkey" {
  key_name = "mnadolkey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}
