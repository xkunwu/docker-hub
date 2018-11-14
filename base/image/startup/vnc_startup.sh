#!/bin/bash
set -e

vncserver :$DISPLAY -localhost -alwaysshared -depth 24 -geometry 1280x800 -rfbauth $HOME/.vnc/passwd
