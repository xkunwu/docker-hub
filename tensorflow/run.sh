#/bin/bash
nvidia-docker run --init -p 5902:5900 gym
#nvidia-docker run -ti --init --rm \
#    -p 5902:5900 \
#    --entrypoint "/bin/bash" \
#    gym
