#! /bin/bash

sudo apt-get update
sudo pip3 install pip -U
sudo pip3 install gdown wget
sudo pip3 install 'numpy<1.22.0' -U
sudo pip3 install matplotlib
sudo pip3 install onnx
sudo pip3 install jetson-stats -U

export HOME=/home/cuterbot

# INSTALL TENSORFLOW, PYTORCH, TOCHVISION, OPENCV
sudo cp $HOME/Cuterbot_2004/scripts/gdrive_repo_cookies.txt "/home/cuterbot/.cache/gdown/cookies.txt"
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

# echo "export LD_PRELOAD=/usr/lib/aarch64-linux-gnu/libgomp.so.1:/usr/lib/aarch64-linux-gnu/libGLdispatch.so.0" >> $HOME/.bashrc