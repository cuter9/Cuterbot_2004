cd nv_docker_settings && ./upgrade_nv_container_rt.sh && cd ..
cd base && ./build.sh && cd ..
# cd models && ./build.sh && cd ..
cd display && ./build.sh && cd ..
cd jupyter && ./build.sh && cd ..
cd camera && ./build.sh && cd ..
