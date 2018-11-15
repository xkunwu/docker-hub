########################################################
# CUDA 9.0 on UBUNTU 18.04 with Miniconda, VNC Server
########################################################
FROM ubuntu:18.04

## generate locale
ENV \
    TERM=xterm-256color
RUN \
    apt-get update && \
    apt-get install -y --no-install-recommends locales && \
    echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "LANG=en_US.UTF-8" > /etc/locale.conf && \
    locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

## essential packages
RUN \
    apt-get install -y \
        software-properties-common sudo bash-completion apt-utils \
        vim tmux unzip bzip2 supervisor \
        wget curl net-tools ca-certificates \
        build-essential cmake git ffmpeg \
        gcc-6 g++-6

## vnc & desktop
RUN \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        # tigervnc-standalone-server \
        tightvncserver \
        # lxde && \
        xfce4 && \
    apt-get purge -y pm-utils xscreensaver* && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

## install cuda from a runfile
ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    NVIDIA_REQUIRE_CUDA="cuda>=9.0"
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

## install Miniconda
ARG PYTHON_VERSION=3.6
RUN \
    curl -o /tmp/miniconda.sh -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x /tmp/miniconda.sh && \
    /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh && \
    /opt/conda/bin/conda install -y python=$PYTHON_VERSION numpy scipy mkl cython jupyterlab && \
    /opt/conda/bin/conda clean -ya
ENV \
    PATH=/opt/conda/bin:$PATH

## add the default user
ARG USER_ME=me
ARG USER_UID=1000
ARG USER_GID=1000
# weird "cp: cannot stat" error:
# cp /root/{.vimrc,.tmux.conf} /home/$USER_ME && \
COPY image /
RUN \
    umask 0002 && \
    echo "create user $USER_ME ($USER_UID:$USER_GID)" && \
    # useradd --uid $USER_UID --user-group --create-home --shell /bin/bash --groups adm,sudo,root $USER_ME && \
    groupadd --gid $USER_GID $USER_ME && \
    useradd --uid $USER_UID --gid $USER_GID --create-home --shell /bin/bash --groups adm,sudo,root $USER_ME && \
    echo "$USER_ME:123123" | chpasswd && \
    cp -t /home/$USER_ME /root/.vimrc /root/.tmux.conf && \
    mkdir -p /home/$USER_ME/.vnc && \
    cp -t /home/$USER_ME/.vnc /root/.vnc/xstartup && \
    chmod 755 /home/$USER_ME/.vnc/xstartup && \
    mkdir -p /workspace && \
    chown -R $USER_UID:$USER_GID /workspace && \
    ln -s /workspace /root/workspace && \
    ln -s /workspace /home/$USER_ME/workspace && \
    chown -R $USER_UID:$USER_GID /home/$USER_ME && \
    find /startup -name '*.sh' -exec chmod a+x {} + && \
    chown -R $USER_UID:$USER_GID /startup && \
    rm -f /startup.sh && \
    ln -s /startup/startup_cuda.sh /startup.sh
ENV \
    DISPLAY=2 VNC_PORT=5902 \
    HOME=/home/$USER_ME USER=$USER_ME SHELL=/bin/bash

## vnc jupyter tensorboard
EXPOSE $VNC_PORT 8888 6006

## user mode container
USER $USER_UID

## ENTRYPOINT ["/startup.sh"]
CMD ["/startup.sh"]
