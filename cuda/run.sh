nvidia-docker run -it --init --rm \
    -p 6080:80 -p 5901:5900 \
    -e HOST_PERMS="$(id -u):$(id -g)" \
    cuda:9.0-ubuntu18.04 bash
