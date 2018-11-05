FROM cuda:9.0-ubuntu18.04

###########################################
# miniconda
###########################################
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 \
    PATH=/opt/conda/bin:$PATH
ARG PYTHON_VERSION=3.6

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        software-properties-common \
        curl wget sudo supervisor net-tools \ 
        dbus-x11 x11-utils \
        mesa-utils libgl1-mesa-dri \
        lxde x11vnc xvfb ffmpeg \
    && apt-get autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/*

#RUN curl -o ~/miniconda.sh -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
#     chmod +x ~/miniconda.sh && \
#     ~/miniconda.sh -b -p /opt/conda && \
#     rm ~/miniconda.sh && \
#     /opt/conda/bin/conda install -y python=$PYTHON_VERSION numpy scipy mkl mkl-include cython jupyter && \
#     /opt/conda/bin/conda clean -ya && \
#    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
#    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc

###########################################
# Tensorflow + Jupyterlab
###########################################
# installing both cpu and gpu versions
# because installing gpu version alone will give only "tensorflow-gpu" package, 
# which is easily overriden by "tensorflow" (when you installing some packages) which has no gpu support


# vnc jupyter tensorboard port
EXPOSE 5900 8888 6006

# startup
COPY image /

ENV HOME=/root \
    SHELL=/bin/bash \
    DISPLAY=:1 \
    JUPYTER_PASSWORD="" \
    JUPYTER_TOKEN="" 

WORKDIR /root
# services like lxde, xvfb, x11vnc will be started
ENTRYPOINT ["/startup.sh"]
