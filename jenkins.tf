data "template_file" "jenkins-configuration" {
  template = "${file("${path.module}/templates/jenkins.tpl")}"
  vars {
   pre_tag="${var.pre_tag}"
  }
}

resource "null_resource" "jenkins-dcos-installation" {
  depends_on = ["null_resource.setup-backup-nfs"]
  provisioner "local-exec" {
    command = "echo '${data.template_file.jenkins-configuration.rendered}' > ${path.module}/templates/jenkins-config.json"
  }
  provisioner "local-exec" {
    command = "curl -X POST ${var.dcos_url}/service/marathon/v2/apps -d @${path.module}/templates/jenkins-config.json -H 'Content-Type: application/json'"
  }
}

resource "null_resource" "setup-backup-nfs" {
  count = "${var.restore_jenkins}"
  connection {
    host = "${var.agent_ip}"
    user = "core"
    agent = true
  }
  provisioner "local-exec" {
    command = "aws s3 cp s3://${var.jenkins_restore_s3_path} ${path.module}/data/jenkins-backup/jenkins-${var.pre_tag}.tar.gz"
  }
  provisioner "file" {
    source = "${path.module}/data/jenkins-backup/jenkins-${var.pre_tag}.tar.gz"
    destination = "/tmp/jenkins-${var.pre_tag}.tar.gz"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo cp /tmp/jenkins-${var.pre_tag}.tar.gz  /var/jenkins_nfs/",
			"cd /var/jenkins_nfs/ && mkdir -p jenkins-${var.pre_tag} && sudo tar xvf jenkins.tar.gz -C jenkins-${var.pre_tag}",
			"sudo rm -rf jenkins-${var.pre_tag}.tar.gz"
    ]
  }
}
