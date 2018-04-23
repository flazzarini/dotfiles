# Set keyboard repeat rate
xset r rate 200 55

# Set keyboard layout to gb
setxkbmap -layout gb

# Start udiskie
udiskie --tray &

# Select the session
#DEFAULTSESSION=dbus-launch --exit-with-session --sh-syntax i3
DEFAULTSESSION=i3


case "$1" in
    openbox) exec openbox-session ;;
    xfce) exec xfce4-session ;;
    gnome3) exec gnome-session ;;
    kde) exec startkde ;;
    cinnamon) exec gnome-session-cinnamon ;;
    razor-qt) exec razor-session ;;
    lxde) exec lxsession ;;
    mate) exec mate-session ;;
    #i3) exec dbus-launch --exit-with-session --sh-syntax i3 ;;
    i3) exec i3 ;;
    *) exec $DEFAULTSESSION ;;
esac
