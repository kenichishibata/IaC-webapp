data "template_file" "jenkins-configuration" {
  template = "${file("${path.module}/templates/jenkins.tpl")}"
  vars {
   pre_tag="${var.pre_tag}"
  }
}

resource "null_resource" "jenkins-dcos-installation" {
  provisioner "local-exec" {
    command = "echo '${data.template_file.jenkins-configuration.rendered}' > ${path.module}/templates/jenkins-config.json"
  }
  provisioner "local-exec" {
    command = "curl -X POST ${var.dcos_url}/service/marathon/v2/apps -d @${path.module}/templates/jenkins-config.json -H 'Content-Type: application/json'"
  }
}