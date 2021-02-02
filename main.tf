#
#
#

resource "null_resource" "raspberrypi" {
    connection {
        type = "ssh"
        user = "${var.username}"
        private_key = "${file("~/.ssh/id_rsa")}"
        time_out = "2m"
        host = "${var.raspberrypi_ip}"
    }

provisioner "remote_exec" {
    inline=[
      # SET HOSTNAME 
      "sudo hostnamectl set-hostname ${var.new_hostname}",
      "echo '127.0.1.1 ${var.new_hostname}' | sudo tee -a /etc/hosts",
     
      # DATE TIME CONFIG
      "sudo timedatectl set-timezone ${var.timezone}",
      "sudo timedatectl set-ntp true",

      # SYSTEM AND PACKAGE UPDATES
      "sudo apt-get update -y",
      "sudo apt-get upgrade -y",
      "sudo apt-get dist-upgrade -y",
      "sudo apt --fix-broken install -y",

      # ENABLE CONTAINER FEATURES IN KERNEL
      "echo 'cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory' | sudo tee -a /boot/cmdline.txt",
      
      # OPTIMIZE GPU MEMORY
      "echo 'gpu_mem=16' | sudo tee -a /boot/config.txt",

      # INSTALL K3S
      "curl -sfL https://get.k3s.io | sh -",

      # BOOTSTRAPING YOUR SERVER
      "sudo k3s server",
      "sudo k3s kubectl get node -o wide",
      "k3s kubectl get nodes",
      "k3s kubectl get po",
      "k3s kubectl get po,svc,deploy",



    ]


}




}
