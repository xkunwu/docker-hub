########################################################
# UBUNTU 18.04 with Miniconda, VNC Server
########################################################
FROM ubuntu:18.04
ARG USER_ME=me
ARG USER_UID=1000
ARG USER_GID=1000

ENV \
    TERM=xterm-256color
# generate locale
RUN \
    apt-get update && \
    apt-get install -y --no-install-recommends locales && \
    echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "LANG=en_US.UTF-8" > /etc/locale.conf && \
    locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# essential packages
RUN \
    apt-get install -y \
        software-properties-common sudo bash-completion apt-utils \
        vim tmux unzip bzip2 supervisor \
        wget curl net-tools ca-certificates \
        build-essential cmake git ffmpeg

# vnc & desktop
RUN \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        # tigervnc-standalone-server \
        tightvncserver \
        # lxde && \
        xfce4 && \
    apt-get purge -y pm-utils xscreensaver* && \
    rm -rf /var/lib/apt/lists/*

# add the default user
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
    ln -s /startup/startup_base.sh /startup.sh

ENV \
    DISPLAY=2 VNC_PORT=5902 \
    HOME=/home/$USER_ME USER=$USER_ME SHELL=/bin/bash

# vnc jupyter tensorboard
EXPOSE $VNC_PORT 8888 6006

USER $USER_UID

# ENTRYPOINT ["/startup.sh"]
CMD ["/startup.sh"]
