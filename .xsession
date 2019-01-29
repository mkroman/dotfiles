xset -dpms
xset s off

xset -b

xset r rate 250 35

# Set the keyboard layout.
setxkbmap -model apple -layout us -variant mac
xmodmap ~/.Xmodmap

# Load nvidia settings.
nvidia-settings --load-config-only &

urxvtd -q -o -f
