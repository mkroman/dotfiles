#!/bin/sh

WM=${WM:-i3}
BROWSER=${BROWSER:-firefox}

export BROWSER

# Add ~/.bin to PATH for use in `dmenu` etc.
export PATH=$HOME/.bin:$PATH

# WM-specific autolaunch
case $WM in
  sway)
    # Merge resources from a file.
    xrdb -merge ~/.Xresources

    # Start notification daemon.
    dunst -config "${HOME}/.config/dunst/dunstrc" &

    # Load nvidia settings.
    nvidia-settings --load-config-only &

    # Start the urxvt daemon. (see urxvt(1))
    urxvtd -q -o -f
    ;;
  openbox|awesome|i3)
    # Merge resources from a file.
    xrdb -merge ~/.Xresources

    # Disable the screensaver.
    xset s off
    xset dpms 600 900 1800

    # Set the key-repeat rate to be quicker.
    xset r rate 250 50

    # Set the keyboard layout.
    setxkbmap -model apple -layout us -variant mac
    xmodmap ~/.Xmodmap

    # Start desktop applications.
    dex -a -s ~/.config/autostart &

    # Start notification daemon.
    dunst -config "${HOME}/.config/dunst/dunstrc" &

    # Start client compositor.
    picom -b

    # Load nvidia settings.
    nvidia-settings --load-config-only &

    # Automatically hide the mouse cursor when the mouse is not in use.
    unclutter -grab &

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
  sway)
    exec sway --my-next-gpu-wont-be-nvidia;;
  *)
    exec i3;;
esac
