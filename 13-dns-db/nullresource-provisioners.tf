
# Create a Null Resource and Provisioners
resource "null_resource" "name" {
  triggers = {
    bastion_public_ip = aws_eip.bastion_eip.public_ip
  }

  depends_on = [module.ec2_public]
  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type        = "ssh"
    host        = self.triggers.bastion_public_ip
    user        = "ec2-user"
    password    = ""
    private_key = file("C:\\Users\\hungtran\\.ssh\\terraform-key.pem")
  }

  # Copies the terraform-key.pem file to /tmp/terraform-key.pem
  provisioner "file" {
    source      = "C:\\Users\\hungtran\\.ssh\\terraform-key.pem"
    destination = "/tmp/terraform-key.pem"
  }

  # Using remote-exec provisioner fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/terraform-key.pem"
    ]
  }
  # local-exec provisioner (Creation-Time Provisioner - Triggered during Create Resource)
  provisioner "local-exec" {
    command     = "echo VPC created on `date` and VPC ID: ${module.vpc.vpc_id} >> creation-time-vpc-id.txt"
    working_dir = "local-exec-output-files/"
    #on_failure = continue
  }
}
