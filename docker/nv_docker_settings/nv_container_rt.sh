#!/bin/bash

py38=$(sed -n '/python3.8/ p' /etc/nvidia-container-runtime/host-files-for-container.d/tensorrt.csv)
if [[ -z $py38 ]]; then
  sudo echo "dir, /usr/local/lib/python3.8/dist-packages/tensorrt" >> /etc/nvidia-container-runtime/host-files-for-container.d/tensorrt.csv
  sudo echo "dir, /usr/local/lib/python3.8/dist-packages/graphsurgeon" >> /etc/nvidia-container-runtime/host-files-for-container.d/tensorrt.csv
  sudo echo "dir, /usr/local/lib/python3.8/dist-packages/uff" >> /etc/nvidia-container-runtime/host-files-for-container.d/tensorrt.csv
  sudo echo "dir, /usr/local/lib/python3.8/dist-packages/onnx_graphsurgeon" >> /etc/nvidia-container-runtime/host-files-for-container.d/tensorrt.csv
fi

  sudo sed -i "s/usr\/lib\/python3.6/usr\/local\/lib\/python3.6/g" /etc/nvidia-container-runtime/host-files-for-container.d/tensorrt.csv

