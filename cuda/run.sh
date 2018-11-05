#/bin/bash
#nvidia-docker run --init -p 5902:5900 cuda:9.0-ubuntu18.04
nvidia-docker run -ti --init --rm \
    -v ${PWD}:${HOME}/work \
    -p 5902:5900 \
    --entrypoint "/bin/bash" \
    cuda:9.0-ubuntu18.04
