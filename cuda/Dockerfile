########################################################
# CUDA 9.0 ON UBUNTU 18.04
########################################################
FROM ubuntu:18.04

ENV NVIDIA_VISIBLE_DEVICES all \
    NVIDIA_DRIVER_CAPABILITIES compute,utility \
    NVIDIA_REQUIRE_CUDA "cuda>=9.0" \
    PATH /usr/local/cuda-9.0/bin:${PATH} \
    LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64:$LD_LIBRARY_PATH \
    USER=me USER_ID=1000 USER_GID=1000

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        software-properties-common sudo supervisor \
        build-essential git wget curl unzip vim ca-certificates \
        dbus-x11 x11-utils \
        mesa-utils libgl1-mesa-dri \
        lxde x11vnc xvfb ffmpeg \
        gcc-6 g++-6 \
    && apt-get autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/*
    && groupadd --gid "${USER_GID}" "${USER}" && \
    useradd --uid ${USER_ID} --gid ${USER_GID} \
        --create-home --shell /bin/bash --groups adm,sudo \
        ${USER} \

# install cuda from a runfile
COPY cuda /tmp/cuda
RUN cd /tmp/cuda \
    && chmod +x cuda-run \
    && ./cuda-run --silent --toolkit --override \
    && tar -xzf cudnn.tgz \
    && cp -P cuda/include/cudnn.h /usr/local/cuda-9.0/include \
    && cp -P cuda/lib64/libcudnn* /usr/local/cuda-9.0/lib64/ \
    && chmod a+r /usr/local/cuda-9.0/lib64/libcudnn* \
    && rm -rf /tmp/cuda \
    && ln -s /usr/bin/gcc-6 /usr/local/cuda/bin/gcc \
    && ln -s /usr/bin/g++-6 /usr/local/cuda/bin/g++

# vnc jupyter tensorboard port
EXPOSE 5900 8888 6006

# startup
COPY image /

ENV HOME=/root \
    SHELL=/bin/bash \
    DISPLAY=:1

WORKDIR ${HOME}
# services like lxde, xvfb, x11vnc will be started
ENTRYPOINT ["/startup.sh"]
