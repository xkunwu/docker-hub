########################################################
# CUDA 9.0 on UBUNTU 18.04 with Miniconda, VNC Server
########################################################
FROM exp:base
ARG PYTHON_VERSION=3.6

USER root

# install cuda from a runfile
#COPY --chown=$USER_UID:$USER_GID cuda /tmp/cuda
COPY cuda /tmp/cuda
RUN \
    cd /tmp/cuda && \
    chmod +x ./cuda-run && \
    ./cuda-run --silent --toolkit --override && \
    tar -xzf cudnn.tgz && \
    cp -P cuda/include/cudnn.h /usr/local/cuda-9.0/include && \
    cp -P cuda/lib64/libcudnn* /usr/local/cuda-9.0/lib64/ && \
    chmod a+r /usr/local/cuda-9.0/lib64/libcudnn* && \
    rm -rf /tmp/cuda && \
    ln -s /usr/bin/gcc-6 /usr/local/cuda/bin/gcc && \
    ln -s /usr/bin/g++-6 /usr/local/cuda/bin/g++
ENV \
    PATH=/usr/local/cuda-9.0/bin:${PATH} \
    LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64:$LD_LIBRARY_PATH


RUN \
    echo "install Miniconda" && \
    curl -o /tmp/miniconda.sh -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x /tmp/miniconda.sh && \
    /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh && \
    /opt/conda/bin/conda install -y python=$PYTHON_VERSION numpy scipy mkl cython jupyterlab && \
    /opt/conda/bin/conda clean -ya
ENV \
    PATH=/opt/conda/bin:$PATH

ARG USER_ME=me
ARG USER_UID=1000
ARG USER_GID=1000
# update scripts
COPY image /
RUN \
    find /startup -name '*.sh' -exec chmod a+x {} + && \
    chown -R $USER_UID:$USER_GID /startup && \
    rm -f /startup.sh && \
    ln -s /startup/startup_base.sh /startup.sh

# vnc jupyter tensorboard
EXPOSE $VNC_PORT 8888 6006

USER $USER_UID

# ENTRYPOINT ["/startup.sh"]
CMD ["/startup.sh"]
