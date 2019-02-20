#!/bin/sh

WM=${WM:-i3}
BROWSER=${BROWSER:-firefox}

# Stupid Fedora shenanigans!
if command -v urxvt256c >/dev/null 2>&1; then
  TERMINAL=${TERMINAL:-urxvt256c}
  export TERMINAL
fi

export BROWSER

# WM-specific autolaunch
case $WM in
  openbox|awesome|i3)
    # Merge resources from a file.
    xrdb -merge ~/.Xresources

    # Disable the screensaver.
    xset s off
    xset -dpms

    # Set the key-repeat rate to be quicker.
    xset r rate 250 50

    # Set the keyboard layout.
    setxkbmap -model apple -layout us -variant mac
    xmodmap ~/.Xmodmap

    # Start desktop applications.
    # dapper -s -u &

    # Start notification daemon.
    dunst -config "${HOME}/.config/dunst/dunstrc" &

    # Start client compositor.
    compton --config "${HOME}/.config/compton.conf" &

    # Load nvidia settings.
    nvidia-settings --load-config-only &

    # Automatically hide the mouse cursor when the mouse is not in use.
    unclutter -grab &

    # Start the urxvt daemon. (see urxvt(1))
    urxvtd -q -o -f

    # Start qbittorrent
    # qbittorrent &
    ;;
esac


# Set the background for select environments.
case $WM in
  openbox|awesome|i3)
    [ -e "${HOME}/.fehbg" ] && source "${HOME}/.fehbg"
    ;;
esac

# Launch the window manager.
case $WM in
  openbox)
    exec openbox-session;;
  gnome)
    exec gnome-session;;
  awesome)
    exec awesome;;
  i3)
    exec i3;;
  *)
    exec i3;;
esac