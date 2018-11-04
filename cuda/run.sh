nvidia-docker run -it --rm \
    -e HOST_PERMS="$(id -u):$(id -g)" \
    cuda:9.0-ubuntu18.04 bash
