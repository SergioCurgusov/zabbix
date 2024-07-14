Vagrant.configure("2") do |config|
  config.vm.box = "almalinux/9"
  config.vm.box_version = "9.3.20231118"
  config.vm.network "public_network", ip: "192.168.38.200"
  config.vm.provision "shell", path: "script.sh"
end