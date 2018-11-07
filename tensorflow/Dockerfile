FROM cuda:9.0-ubuntu18.04

ENV PATH=/opt/bazel/bin:$PATH \
    TMP=/tmp

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    python3-dev && \
    apt-get autoremove && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    pip install six numpy wheel mock && \
    pip install keras_applications==1.0.5 --no-deps && \
    pip install keras_preprocessing==1.0.3 --no-deps && \
    rm -rf ~/.cache/pip


###########################################
# Tensorflow
###########################################
COPY tf /tmp/tf
RUN cd /tmp/tf && \
    chmod +x ./bazel-run.sh && \
    ./bazel-run.sh --prefix=/opt/bazel && \
    rm -rf /tmp/tf && \
    cd /opt && \
    git clone https://github.com/tensorflow/tensorflow.git && \
    cd tensorflow

WORKDIR /opt/tensorflow
