#! /bin/bash

sudo apt-get update
sudo pip3 install pip -U
sudo pip3 install gdown
sudo pip3 install 'numpy<1.24.0' -U
sudo pip3 install matplotlib
sudo pip3 install onnx
sudo pip3 install jetson-stats -U

export HOME=/home/cuterbot

# INSTALL TENSORFLOW, PYTORCH, TOCHVISION, OPENCV 
gdown --folder https://drive.google.com/drive/folders/1mRBVWVFVVIGWK1F27X_m7r6XJDjVusX5 -O ${HOME}/repo
pushd ${HOME}/repo
bash ./opencv-python_requirements.sh
sudo pip3 install *.whl

# INSTALL TORCH2TRT
sudo apt-get install -y libomp-dev libopenblas-dev libopenmpi-dev
git clone https://github.com/NVIDIA-AI-IOT/torch2trt 
cd torch2trt
python3 setup.py bdist_wheel
cd dist
sudo pip3 install *.whl

cd ${HOME}/repo
# INSTALL pycuda
bash ./install_pycuda.sh

popd
