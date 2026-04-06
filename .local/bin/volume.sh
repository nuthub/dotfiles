#!/usr/bin/env bash
# inspired by https://wiki.archlinux.org/title/Dunst#Using_dunstify_as_volume/brightness_level_indicator

myname=$(basename $0)

notify_sink() {
    canberra-gtk-play -i audio-volume-change -d $myname
    # $((10#$(...))) removes leading zero (interpretes ... as number with base 10)
    volume=$((10#$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed 's/[^0-9]//g')))
    mute="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep MUTED)"
    if [[ $volume == 0 || ! -z "$mute" ]]; then
	# Show the sound muted notification
	notify-send -a $myname \
		    -u low \
		    -i audio-volume-muted \
		    -h string:x-dunst-stack-tag:volume \
		    "Volume muted" 
    else
	# Show the set volume
	notify-send -a $myname \
		    -u low \
		    -i audio-volume-high \
		    -h string:x-dunst-stack-tag:volume \
		    -h int:value:"$volume" \
		    "Volume: ${volume}%"
    fi
}

notify_source() {
    canberra-gtk-play -i audio-volume-change -d $myname
    mute="$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep MUTED)"
    if [[ ! -z "$mute" ]]; then
	notify-send -a $myname \
		    -u low \
		    -i audio-volume-muted \
		    -h string:x-dunst-stack-tag:microphone \
		    "Microphone muted" 
    else
	notify-send -a $myname \
		    -u low \
		    -i audio-volume-muted \
		    -h string:x-dunst-stack-tag:microphone \
		    "Microphone unmuted" 	
    fi
}

case $1 in
    "up")
	wpctl set-volume @DEFAULT_AUDIO_SINK@ -l 1.2 5%+ > /dev/null
	notify_sink
	;;
    "down")
	wpctl set-volume @DEFAULT_AUDIO_SINK@ -l 1.2 5%- > /dev/null
	notify_sink
	;;
    "mute")
	wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle > /dev/null
	notify_sink
	;;
    "mic-mute")
	wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle > /dev/null
	notify_source
	;;
    *)
	echo "Usage: $(basename $0) <command>"
	echo "Possible commands:"
	echo "   up"
	echo "   down"
	echo "   mute"
	echo "   mic-mute"
	exit 0
	;;
esac
