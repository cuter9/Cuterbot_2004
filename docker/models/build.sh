sudo docker build \
    --build-arg BASE_IMAGE=$CUTERBOT_DOCKER_REMOTE/cuterbot:base-$CUTERBOT_IMAGES_TAG \
    -t $CUTERBOT_DOCKER_REMOTE/cuterbot:models-$CUTERBOT_IMAGES_TAG \
    -f Dockerfile .
