#!/bin/bash

# config the screen resolution
if [ -n "$RESOLUTION" ]; then
    sed -i "s/1280x800/$RESOLUTION/" /usr/local/bin/xvfb.sh
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
