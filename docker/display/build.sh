sudo pip3 install jetson-stats -U
sudo docker build \
    --build-arg BASE_IMAGE=$CUTERBOT_DOCKER_REMOTE/cuterbot:base-$CUTERBOT_IMAGES_TAG \
    -t $CUTERBOT_DOCKER_REMOTE/cuterbot:display-$CUTERBOT_IMAGES_TAG \
    -f Dockerfile .

