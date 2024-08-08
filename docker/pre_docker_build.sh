cd nv_docker_settings && ./upgrade_nv_container_rt.sh && cd ..
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker