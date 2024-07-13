# Cuterbot 2004 
For Cuterbot to run on python3.8.10 and ubuntu 20.04, the NV jetbot original codes are modified as following:
1. The ubuntu is upgrade from 18.04 to 20.04 with reference to https://qengineering.eu/install-ubuntu-20.04-on-jetson-nano.html.
2. The jetpack for python3.8 was built and installed.
3. The cuterbot docker images was built base on nvidia l4t-base image. 
4. The jetpack lib for pathon3.8 was included in mount lib cvs in /etc/nvdia-container-runtime.
5. The power status from ina3221 was add to the jetbot apps and docker image display with reference to https://github.com/semaf/INA3221-Python-Library.
6. The tensorflow v2.9.3 for python3.8 and ubuntu 20.04 was built (with some patches) and installed.
7. The torch v1.13.0 and torchvisio v0.14.0 was installed with reference to https://github.com/Qengineering/PyTorch-Jetson-Nano.
8. The qwiic and its dependence qwiic-i2c was built from source, and qwiic-i2c version < 1.0.0 must be used.
9. The model YOLO, MOBILNET, SSD, IncentNet was included.
10. The fleet following function was added.
11. The operation interfaces was modified to be more neat from operation view.

# Installation
1. Install Jetpack version 4.6.5, L4T version 32.7.5 for Jetson Nano with Nvidia Jetpack SDK.
2. Upgrade Jetson Nano to Ubuntu 20.04 with reference to https://qengineering.eu/install-ubuntu-20.04-on-jetson-nano.html
3. cd ~/
4. git clone https://github.com/cuter9/Cuterbot_2004.git
5. sudo chmod -R 777 ~/Cuterbot_2004
6. sudo chown -R $(whoami) ~/Cuterbot_2004
7. cd ~/Cuterbot_2004/scripts
8. ./enable_swap.sh
9. ./requirement_4_cuterbot.sh
10. cd ~/Cuterbot_2004/docker
11. source ./configure.sh
12. sudo groupadd docker && sudo usermod -aG docker $USER && newgrp docker
13. ./build.sh
14. ./enable.sh

# Issues
1. if "RuntimeError: Coul not initilize camera.",
   a. run ./restart_docker.sh to restart docker daemon and nvargus-daemon
   b. restart jupyter lab

