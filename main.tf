provider "aws" {
  region = "eu-central-1"
}


resource "aws_s3_bucket" "b" {
  bucket = "testing-dme-demo-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "null_resource" "ansible_provisioner" {
  # Use null_resource as a trigger for local-exec provisioner
  triggers = {
    s3_id = aws_s3_bucket.b.id
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i '/tmp/ansiform/aws_s3_inventory.py' playbook.yml"
  }
}
