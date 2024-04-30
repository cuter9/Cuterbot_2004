#!/bin/bash
sudo apt update && sudo apt-get install curl
curl -s -L https://nvidia.github.io/libnvidia-container/stable/ubuntu18.04/nvidia-container-toolkit.list | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt update && \
  sudo apt-get upgrade -y nvidia-container-toolkit \
  libnvidia-container1 \
  libnvidia-container0 \
  libnvidia-container-tools \
  nvidia-container-runtime \
  nvidia-docker2 \
  nvidia-container-csv-cuda \
  nvidia-container-csv-cudnn \
  nvidia-container-csv-tensorrt \
  nvidia-container-csv-visionworks

sudo cp ./host-files-for-container.d/l4t.csv /etc/nvidia-container-runtime/host-files-for-container.d/
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker

# py38=$(sed -n '/python3.8/ p' /etc/nvidia-container-runtime/host-files-for-container.d/tensorrt.csv)
# if [[ -z $py38 ]]; then
#  sudo echo "dir, /usr/local/lib/python3.8/dist-packages/tensorrt" >> /etc/nvidia-container-runtime/host-files-for-container.d/tensorrt.csv
#  sudo echo "dir, /usr/local/lib/python3.8/dist-packages/graphsurgeon" >> /etc/nvidia-container-runtime/host-files-for-container.d/tensorrt.csv
#  sudo echo "dir, /usr/local/lib/python3.8/dist-packages/uff" >> /etc/nvidia-container-runtime/host-files-for-container.d/tensorrt.csv
#  sudo echo "dir, /usr/local/lib/python3.8/dist-packages/onnx_graphsurgeon" >> /etc/nvidia-container-runtime/host-files-for-container.d/tensorrt.csv
#fi

#  sudo sed -i "s/usr\/lib\/python3.6/usr\/local\/lib\/python3.6/g" /etc/nvidia-container-runtime/host-files-for-container.d/tensorrt.csv
  
#sym=$(sed -n '/sym,/ p' /etc/nvidia-container-runtime/host-files-for-container.d/cuda.csv)
#if [[ -z $sym ]]; then
#  sudo echo "sym, /usr/local/cuda" >> /etc/nvidia-container-runtime/host-files-for-container.d/cuda.csv
#  sudo echo "sym, /usr/local/cuda-10" >> /etc/nvidia-container-runtime/host-files-for-container.d/cuda.csv
#fi


