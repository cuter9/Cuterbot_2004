cp /etc/apt/trusted.gpg.d/jetson-ota-public.asc ../.. # copy to jetbot root
# sudo rm /usr/share/keyrings/kitware-archive-keyring.gpg
# sudo apt-get install kitware-archive-keyring
# cp -r ${HOME}/repo ../../repo

# gdown --folder https://drive.google.com/drive/folders/1mRBVWVFVVIGWK1F27X_m7r6XJDjVusX5 -O $HOME/repo

docker build -t $CUTERBOT_DOCKER_REMOTE/cuterbot:base-$CUTERBOT_IMAGES_TAG \
	--build-arg BASE_IMAGE=$JETBOT_BASE_IMAGE \
	--build-arg HOME=$HOME \
	-f Dockerfile_$CUTERBOT_IMAGES_TAG \
	$HOME 2>&1 | tee build_cuterbot_base_$CUTERBOT_IMAGES_TAG.log
# jetbot repo root as context
# docker run -t cuterbot/jetbot:base-1.0.0-32.7.4 "pip3 install /repo/setup.py install"

# rm -rf ../../repo

