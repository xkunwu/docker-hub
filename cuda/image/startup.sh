#!/bin/bash

# config the screen resolution
if [ -n "$RESOLUTION" ]; then
    sed -i "s/1280x800/$RESOLUTION/" /usr/local/bin/xvfb.sh
fi

USER=${USER:-root}
# HOME=/root
if [ "$USER" != "root" ]; then
    echo "* enable custom user: $USER"
    useradd --uid 1000 --create-home --shell /bin/bash --user-group --groups adm,sudo $USER
    if [ -z "$PASSWORD" ]; then
        echo "  set default password to \"123123\""
        PASSWORD=123123
    fi
    HOME=/home/$USER
    echo "$USER:$PASSWORD" | chpasswd
    cp -r /root/{.vimrc,.tmux.conf} ${HOME}
    chown -R $USER:$USER $HOME
fi
# sed -i "s|%(ENV_USER)s|$USER|" /etc/supervisor/conf.d/supervisord.conf
# sed -i "s|%(ENV_HOME)s|$HOME|" /etc/supervisor/conf.d/supervisord.conf

# clearup
PASSWORD=

# start all the services
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
