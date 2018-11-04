########################################################
# CUDA 9.0 ON UBUNTU 18.04
########################################################
FROM ubuntu:18.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential git wget curl unzip vim ca-certificates \
    gcc-6 g++-6 

# nvidia-docker
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=9.0"

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

# set cuda paths
ENV PATH /usr/local/cuda-9.0/bin:${PATH}
ENV LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64:$LD_LIBRARY_PATH

