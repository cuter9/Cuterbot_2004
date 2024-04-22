# Cuterbot 2004 
For jetbot to run on python3.8 and ubuntu 20.04, the NV jetbot original codes are modified as following
1. The ubuntu is upgrade from 18.04 to 20.04.
2. The jetpack for python3.8 was built and installed.
3. The jetpack lib for pathon3.8 was included in mount lib cvs in /etc/nvdia-container-runtime.
4. The power status from ina3221 was add to the jetbot apps and docker image display.
5. The tensorflow v2.9.3 for python3.8 and ubuntu 20.04 was built (with some patches) and install.
6. The torch v1.13.0 and torchvisio v0.14.0 was installed with reference to https://github.com/Qengineering/PyTorch-Jetson-Nano.
7. The qwiic and its dependence qwiic-i2c was built from source, and qwiic-i2c version < 1.0.0 must be used.

