FROM cuda:9.0-ubuntu18.04

###########################################
# miniconda
###########################################
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH
ARG PYTHON_VERSION=3.6

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        software-properties-common \
        curl wget sudo \
        lxde xvfb tightvncserver \
    && apt-get autoremove --purge \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update --fix-missing && \
    apt-get install -y && \
    wget bzip2 ca-certificates curl git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -o ~/miniconda.sh -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
     /opt/conda/bin/conda install -y python=$PYTHON_VERSION numpy scipy mkl mkl-include cython jupyter && \
     /opt/conda/bin/conda clean -ya && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc

###########################################
# Tensorflow + Jupyterlab
###########################################
# installing both cpu and gpu versions
# because installing gpu version alone will give only "tensorflow-gpu" package, 
# which is easily overriden by "tensorflow" (when you installing some packages) which has no gpu support

###########################################
# X11 VNC XVFB
# integrated from https://github.com/fcwu/docker-ubuntu-vnc-desktop
###########################################
# taken from https://github.com/fcwu/docker-ubuntu-vnc-desktop
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        software-properties-common \
        curl wget \
        supervisor \
        sudo \
        vim-tiny \
        net-tools \ 
        xz-utils \
        dbus-x11 x11-utils alsa-utils \
        mesa-utils libgl1-mesa-dri \
        lxde x11vnc xvfb \
        gtk2-engines-murrine gnome-themes-standard gtk2-engines-pixbuf gtk2-engines-murrine arc-theme \
        firefox \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

# tini for subreap                                   
ARG TINI_VERSION=v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
RUN chmod +x /bin/tini

# set default screen to 1 (this is crucial for gym's rendering)
ENV DISPLAY=:1

###########################################
# gym
# see: https://github.com/openai/gym
###########################################
RUN apt-get update && apt-get install -y \
        git vim \
        python-numpy python-dev cmake zlib1g-dev libjpeg-dev xvfb ffmpeg xorg-dev python-opengl libboost-all-dev libsdl2-dev swig \
    && rm -rf /var/lib/apt/lists/*

# install gym
RUN cd /opt \
    && git clone https://github.com/openai/gym.git \
    && cd /opt/gym \
    && pip install -e '.[all]' \
    && rm -rf ~/.cache/pip 


# vnc port
EXPOSE 5900
# jupyterlab port
EXPOSE 8888
# tensorboard (if any)
EXPOSE 6006

# startup
COPY image /

ENV HOME /root
ENV SHELL /bin/bash

# no password and token for jupyter
ENV JUPYTER_PASSWORD ""
ENV JUPYTER_TOKEN ""

WORKDIR /root
# services like lxde, xvfb, x11vnc, jupyterlab will be started
ENTRYPOINT ["/startup.sh"]
