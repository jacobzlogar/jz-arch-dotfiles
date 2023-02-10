killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done
#
# # Launch polybar
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    NAME=$(echo "$m" | awk {'print tolower($0)'})
    CONFIG="$HOME/.config/polybar/$NAME.ini"
    MONITOR=$m polybar bottom -c=$CONFIG --reload &
    MONITOR=$m polybar top -c=$CONFIG --reload &
  done
else
  polybar top --reload &
fi
