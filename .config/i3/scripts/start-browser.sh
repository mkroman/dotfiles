#!/bin/sh
# Starts the browser in incognito mode if the current systemd target is
# privacy.target. Otherwise it starts it in normal mode.

$(systemctl is-active privacy.target -q)
[ $? -eq 0 ] && exec chromium --incognito || exec $BROWSER
