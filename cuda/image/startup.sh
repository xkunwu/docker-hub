#!/bin/bash

# config the screen resolution
sed -i "s/1024x768/800x600/" /usr/local/bin/xvfb.sh

# user
USER=${USER:-root}
HOME=/root
if [ "$USER" != "root" ]; then
    echo "* enable custom user: $USER"
    useradd --create-home --shell /bin/bash --user-group --groups adm,sudo $USER
    if [ -z "$PASSWORD" ]; then
        echo "  set default password to \"ubuntu\""
        PASSWORD=ubuntu
    fi
    HOME=/home/$USER
    echo "$USER:$PASSWORD" | chpasswd
    cp -r /root/* ${HOME}
fi
sed -i "s|%USER%|$USER|" /etc/supervisor/conf.d/supervisord.conf
sed -i "s|%HOME%|$HOME|" /etc/supervisor/conf.d/supervisord.conf

# home folder
chown -R $USER:$USER $HOME

# clearup
PASSWORD=
HTTP_PASSWORD=

# start all the services
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
