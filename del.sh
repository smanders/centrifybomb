sudo apt -y purge docker-ce docker-ce-cli containerd.io
sudo apt -y autoremove
sudo rm -rf /var/lib/docker /var/lib/containerd
