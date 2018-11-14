#!/bin/bash
set -e

# ### disable screensaver and power management
# xset -dpms &
# xset s noblank &
# xset s off &

/usr/bin/startxfce4 --replace > $HOME/wm.log &
