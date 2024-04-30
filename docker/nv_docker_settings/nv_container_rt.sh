#!/bin/bash
sudo apt update && sudo apt-get install curl
curl -s -L https://nvidia.github.io/libnvidia-container/stable/ubuntu18.04/nvidia-container-toolkit.list | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt update && \
  sudo apt-get install -y nvidia-container-toolkit=1.7.0-1 \
  libnvidia-container1=1.7.0-1 \
  libnvidia-container0=0.10.0+jetpack \
  libnvidia-container-tools=1.7.0-1 \
  nvidia-container-runtime=3.7.0-1 \
  nvidia-docker2=2.8.0-1 \
  nvidia-container-csv-cuda \
  nvidia-container-csv-cudnn \
  nvidia-container-csv-tensorrt \
  nvidia-container-csv-visionworks
  
py38=$(sed -n '/python3.8/ p' /etc/nvidia-container-runtime/host-files-for-container.d/tensorrt.csv)
if [[ -z $py38 ]]; then
  sudo echo "dir, /usr/local/lib/python3.8/dist-packages/tensorrt" >> /etc/nvidia-container-runtime/host-files-for-container.d/tensorrt.csv
  sudo echo "dir, /usr/local/lib/python3.8/dist-packages/graphsurgeon" >> /etc/nvidia-container-runtime/host-files-for-container.d/tensorrt.csv
  sudo echo "dir, /usr/local/lib/python3.8/dist-packages/uff" >> /etc/nvidia-container-runtime/host-files-for-container.d/tensorrt.csv
  sudo echo "dir, /usr/local/lib/python3.8/dist-packages/onnx_graphsurgeon" >> /etc/nvidia-container-runtime/host-files-for-container.d/tensorrt.csv
fi

  sudo sed -i "s/usr\/lib\/python3.6/usr\/local\/lib\/python3.6/g" /etc/nvidia-container-runtime/host-files-for-container.d/tensorrt.csv
  
sym=$(sed -n '/sym,/ p' /etc/nvidia-container-runtime/host-files-for-container.d/cuda.csv)
if [[ -z $sym ]]; then  
  sudo echo "sym, /usr/local/cuda" >> /etc/nvidia-container-runtime/host-files-for-container.d/cuda.csv
  sudo echo "sym, /usr/local/cuda-10" >> /etc/nvidia-container-runtime/host-files-for-container.d/cuda.csv
fi


