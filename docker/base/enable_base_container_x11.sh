#! /bin/bash

docker run -it --rm \
  --runtime nvidia \
  --network host \
   --privileged \
   --device /dev/video* \
   --volume /dev/bus/usb:/dev/bus/usb \
   --volume /tmp/argus_socket:/tmp/argus_socket \
   -v /tmp/.X11-unix:/tmp/.X11-unix \
   -v $HOME/.Xauthority:/root/.Xauthority \
   -v /run/jtop.sock:/run/jtop.sock \
   -v $HOME/repo:/repo \
   --name=jetpack_container_test \
   --env DISPLAY=$DISPLAY \
   $CUTERBOT_DOCKER_REMOTE/cuterbot:base-$CUTERBOT_IMAGES_TAG bash
   
   # -v $HOME/Downloads/l4t-base/dst/samples:/usr/local/cuda-10.2/samples \
