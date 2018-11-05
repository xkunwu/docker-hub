FROM cuda:9.0-ubuntu18.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    python3-dev \
    && apt-get autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* \
    && pip install tensorflow https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.9.0-cp36-cp36m-linux_x86_64.whl \
    && rm -rf ~/.cache/pip


###########################################
# Tensorflow
###########################################
# installing both cpu and gpu versions
# because installing gpu version alone will give only "tensorflow-gpu" package,
# which is easily overriden by "tensorflow" (when you installing some packages) which has no gpu support

# vnc jupyter tensorboard port
EXPOSE 5900 8888 6006

# services like lxde, xvfb, x11vnc will be started
ENTRYPOINT ["/startup.sh"]
