resource "null_resource" "this" {
  depends_on = [var.instance_id]

  provisioner "remote-exec" {
    inline = var.scripts

    connection {
      type        = "ssh"
      user        = var.user
      host        = var.instance_public_ip
      port        = var.ssh_port
      private_key = file(var.pk_file_path)
    }
  }
}