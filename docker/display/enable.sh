sudo docker run -it -d \
    --restart always \
    --runtime nvidia \
    --network host \
    --privileged \
    --name=jetbot_display \
    --env DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/.Xauthority:/root/.Xauthority \
    $CUTERBOT_DOCKER_REMOTE/cuterbot:display-$CUTERBOT_IMAGES_TAG
