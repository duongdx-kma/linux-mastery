# NUM_OBSERVER_NODE = 1
NUM_SLAVE_NODE = 2
IP_NW = "192.168.56."

SLAVE_IP_START = 89

Vagrant.configure("2") do |config|
  config.vm.box = "generic/centos9s"
  config.vm.box_check_update = false

  config.vm.define "centos9-stream" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "centos9-stream"
        # vb.memory = 512
        # vb.cpus = 0.5
      end
      node.vm.hostname = "centos9-stream"
      node.vm.network :private_network, ip: "192.168.56.166"
      node.vm.network "forwarded_port", guest: 22, host: 16666
  end

  config.vm.provision "setup-deployment-user", type: "shell" do |s|
      ssh_pub_key = File.readlines("./client.pem.pub").first.strip
      s.inline = <<-SHELL
          # create deploy user
          useradd -s /bin/bash -d /home/deploy/ -m -G wheel deploy
          echo 'deploy ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
          mkdir -p /home/deploy/.ssh && chown -R deploy:deploy /home/deploy/.ssh
          echo #{ssh_pub_key} >> /home/deploy/.ssh/authorized_keys
          chown -R deploy:deploy /home/deploy/.ssh/authorized_keys
          chmod -R 0700 /home/deploy/.ssh
          chmod -R 0600 /home/deploy/.ssh/authorized_keys
          # config timezone
          timedatectl set-timezone Asia/Ho_Chi_Minh
      SHELL
  end
end