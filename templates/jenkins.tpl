{
  "id": "/jenkins-${pre_tag}",
  "cmd": null,
  "cpus": 1,
  "mem": 2048,
  "disk": 0,
  "instances": 1,
  "acceptedResourceRoles": [
    "*"
  ],
  "container": {
    "type": "DOCKER",
    "volumes": [
      {
        "containerPath": "/var/jenkins_home",
        "hostPath": "/var/jenkins_nfs/jenkins-${pre_tag}",
        "mode": "RW"
      },
      {
        "containerPath": "/opt/mesosphere",
        "hostPath": "/opt/mesosphere",
        "mode": "RO"
      }
    ],
    "docker": {
      "image": "mesosphere/jenkins:2.0.1-2.7.4",
      "network": "HOST",
      "privileged": false,
      "parameters": [],
      "forcePullImage": false
    }
  },
  "env": {
    "LD_LIBRARY_PATH": "/opt/mesosphere/lib",
    "SSH_KNOWN_HOSTS": "github.com",
    "JENKINS_CONTEXT": "/service/jenkins-${pre_tag}",
    "JENKINS_AGENT_ROLE": "*",
    "JVM_OPTS": "-Xms1024m -Xmx1024m",
    "JENKINS_MESOS_MASTER": "zk://leader.mesos:2181/mesos",
    "JENKINS_AGENT_USER": "root",
    "JENKINS_OPTS": "",
    "JENKINS_FRAMEWORK_NAME": "jenkins-${pre_tag}"
  },
  "healthChecks": [
    {
      "path": "/service/jenkins-${pre_tag}",
      "protocol": "HTTP",
      "portIndex": 0,
      "gracePeriodSeconds": 30,
      "intervalSeconds": 60,
      "timeoutSeconds": 20,
      "maxConsecutiveFailures": 3,
      "ignoreHttp1xx": false
    }
  ],
  "labels": {
    "DCOS_PACKAGE_RELEASE": "13",
    "DCOS_SERVICE_SCHEME": "http",
    "DCOS_PACKAGE_SOURCE": "https://universe.mesosphere.com/repo-1.7",
    "DCOS_PACKAGE_REGISTRY_VERSION": "2.0",
    "DCOS_SERVICE_NAME": "jenkins-${pre_tag}",
    "DCOS_PACKAGE_FRAMEWORK_NAME": "jenkins-${pre_tag}",
    "DCOS_SERVICE_PORT_INDEX": "0",
    "DCOS_PACKAGE_VERSION": "2.0.1-2.7.4",
    "DCOS_PACKAGE_NAME": "jenkins",
    "MARATHON_SINGLE_INSTANCE_APP": "true",
    "DCOS_PACKAGE_IS_FRAMEWORK": "true",
    "HAPROXY_GROUP": "external"
  },
  "portMappings": [
    {
      "containerPort": 8182,
      "hostPort": 0,
      "servicePort": 10000,
      "protocol": "tcp",
      "labels": {}
    },
    {
      "containerPort": 9091,
      "hostPort": 0,
      "servicePort": 10001,
      "protocol": "tcp",
      "labels": {}
    }
  ],
  "portDefinitions": [
    {
      "port": 10000,
      "protocol": "tcp",
      "labels": {}
    },
    {
      "port": 10001,
      "protocol": "tcp",
      "labels": {}
    }
  ],
  "upgradeStrategy": {
    "minimumHealthCapacity": 0,
    "maximumOverCapacity": 0
  }
}
