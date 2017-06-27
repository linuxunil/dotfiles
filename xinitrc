[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
xset -fp ~/.local/share/fonts
xrandr --dpi 196
exec i3
