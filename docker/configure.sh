#!/bin/bash

export JETBOT_VERSION=1.0.0
# export L4T_BASE_IMAGE_TAG=r34.1
# export L4T_BASE_IMAGE_TAG=r35.1.0
export L4T_BASE_IMAGE_TAG=r35.2.1
# export L4T_BASE_IMAGE_TAG=r36.2.0

export CUTERBOT_IMAGES_TAG="$JETBOT_VERSION-$L4T_BASE_IMAGE_TAG"

L4T_VERSION_STRING=$(head -n 1 /etc/nv_tegra_release)
L4T_RELEASE=$(echo $L4T_VERSION_STRING | cut -f 2 -d ' ' | grep -Po '(?<=R)[^;]+')
L4T_REVISION=$(echo $L4T_VERSION_STRING | cut -f 2 -d ',' | grep -Po '(?<=REVISION: )[^;]+')

export L4T_VERSION="$L4T_RELEASE.$L4T_REVISION"

if [[ $L4T_VERSION = "32.4.3" ]]
then
	JETBOT_BASE_IMAGE=nvcr.io/nvidia/l4t-pytorch:r32.4.3-pth1.6-py3
elif [[ "$L4T_VERSION" == "32.4.4" ]]
then
	JETBOT_BASE_IMAGE=nvcr.io/nvidia/l4t-pytorch:r32.4.4-pth1.6-py3
elif [[ "$L4T_VERSION" == "32.5.0" ]] || [[ "$L4T_VERSION" == "32.5.1" ]]
then
	JETBOT_BASE_IMAGE=nvcr.io/nvidia/l4t-pytorch:r32.5.0-pth1.6-py3
elif [[ "$L4T_VERSION" == "32.7.4" ]] || [[ "$L4T_VERSION" == "32.7.5" ]] || [[ "$L4T_VERSION" == "32.7.1" ]]
then
	# JETBOT_BASE_IMAGE=nvcr.io/nvidia/l4t-pytorch:r32.7.1-pth1.10-py3
	# JETBOT_BASE_IMAGE=nvcr.io/nvidia/l4t-jetpack:r32.7.4.1
	JETBOT_BASE_IMAGE=nvcr.io/nvidia/l4t-base:$L4T_BASE_IMAGE_TAG
else
	echo "JETBOT_BASE_IMAGE not found for ${L4T_VERSION}.  Please manually set the JETBOT_BASE_IMAGE environment variable. (ie: export JETBOT_BASE_IMAGE=...)"
fi

export JETBOT_BASE_IMAGE
export CUTERBOT_DOCKER_REMOTE=cuterbot
export HOME=/home/cuterbot

echo "JETBOT_VERSION=$JETBOT_VERSION"
echo "L4T_VERSION=$L4T_VERSION"
echo "JETBOT_BASE_IMAGE=$JETBOT_BASE_IMAGE"
echo "CUTERBOT_DOCKER_REMOTE=$JETBOT_DOCKER_REMOTE"
echo "L4T_RELEASE=$L4T_RELEASE"
echo "CUTERBOT_IMAGES_TAG=$JETBOT_IMAGES_TAG"
echo "HOME=$HOME"

./set_nvidia_runtime.sh
sudo systemctl enable docker

# check system memory
SYSTEM_RAM_KILOBYTES=$(awk '/^MemTotal:/{print $2}' /proc/meminfo)

if [ $SYSTEM_RAM_KILOBYTES -lt 3000000 ]
then
    export JETBOT_JUPYTER_MEMORY=500m
    export JETBOT_JUPYTER_MEMORY_SWAP=3G
fi

