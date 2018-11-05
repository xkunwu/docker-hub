#/bin/bash
#nvidia-docker run --init -p 5902:5900 cuda:9.0-ubuntu18.04
nvidia-docker run -ti --init --rm \
    -p 5902:5900 \
    -v ${PWD}:/workspace/source:ro \
    -e USER=xwu \
    --entrypoint "/bin/bash" \
    cuda:9.0-ubuntu18.04
