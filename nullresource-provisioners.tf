# Create a Null Resource and Provisioners
resource "null_resource" "name" {
  depends_on = [module.ec2_public]
  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type     = "ssh"
    host     = aws_eip.bastion_eip.public_ip    
    user     = "ec2-user"
    password = ""
    private_key = file("private-key/two-tier-key.pem")
  }  

## File Provisioner: Copies the two-tier-key.pem file to /tmp/two-tier-key.pem
  provisioner "file" {
    source      = "private-key/two-tier-key.pem"
    destination = "/tmp/two-tier-key.pem"
  }
## Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/two-tier-key.pem"
    ]
  }
}
