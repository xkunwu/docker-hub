########################################################
# CUDA 9.0 on UBUNTU 18.04 with Miniconda, VNC Server
########################################################
FROM ubuntu:18.04
ARG PYTHON_VERSION=3.6

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    NVIDIA_REQUIRE_CUDA="cuda>=9.0" \
    PATH=/usr/local/cuda-9.0/bin:${PATH} \
    LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64:$LD_LIBRARY_PATH \
    HOME=/root USER=root SHELL=/bin/bash \
    DISPLAY=:1 \
    LANG=C.UTF-8 LC_ALL=C.UTF-8 \
    PATH=/opt/conda/bin:$PATH \
    JUPYTER_PASSWORD="" \
    JUPYTER_TOKEN=""


RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        software-properties-common sudo supervisor tmux \
        build-essential git wget curl unzip vim ca-certificates \
        dbus-x11 x11-utils \
        mesa-utils libgl1-mesa-dri \
        lxde x11vnc xvfb ffmpeg \
        gcc-6 g++-6 && \
    apt-get autoremove && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    curl -o /tmp/miniconda.sh -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x /tmp/miniconda.sh && \
    /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh && \
    /opt/conda/bin/conda install -y python=$PYTHON_VERSION numpy scipy mkl cython jupyterlab && \
    /opt/conda/bin/conda clean -ya

# install cuda from a runfile
COPY cuda /tmp/cuda
RUN cd /tmp/cuda && \
    chmod +x ./cuda-run.sh && \
    ./cuda-run --silent --toolkit --override && \
    tar -xzf cudnn.tgz && \
    cp -P cuda/include/cudnn.h /usr/local/cuda-9.0/include && \
    cp -P cuda/lib64/libcudnn* /usr/local/cuda-9.0/lib64/ && \
    chmod a+r /usr/local/cuda-9.0/lib64/libcudnn* && \
    rm -rf /tmp/cuda && \
    ln -s /usr/bin/gcc-6 /usr/local/cuda/bin/gcc && \
    ln -s /usr/bin/g++-6 /usr/local/cuda/bin/g++

# vnc jupyter tensorboard port
EXPOSE 5900 8888 6006

# startup
COPY image /

# services like lxde, xvfb, x11vnc will be started
ENTRYPOINT ["/startup.sh"]
