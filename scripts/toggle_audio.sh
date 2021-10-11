#!/bin/sh
#
# Toggle Audio between headphone and speaker
# 
# USAGE:
#  	toggle_audio										: Get live output of current device; speaker or headphone. Good for polybar
#  	toggle_audio toggle							: Toggle between speaker and heaphone. Speaker(75% vol) Headphone(50% vol)
#  	toggle_audio toggle keep_vol		: Toggle between speaker and headphone without changing volume.

TMP=/tmp/toggle_audio.tmp
SP=
HP=

SPV=100%
HPV=50%

SSINK=$(pactl list short sinks | rg "output.pci.*.analog-stereo" | cut -f1)
HSINK=$(pactl list short sinks | rg "output.usb-Blue_Microphone" | cut -f1)

VOL=1

case $2 in 
	keep_vol) VOL=0
esac

get_type () {
	sink_name=$(pacmd stat | rg "Default sink" | cut -d':' -f2)
	sink_idx=$(pactl list short sinks | rg $sink_name | cut -f1)
	
	if [[ $sink_idx = $SSINK ]]; then
		echo $SP 
	else
		echo $HP 
	fi
}

swap_sink () {
	sink=$1
	vol=$2
	
	pacmd set-default-sink $sink

	# move inputs to new sink
	pactl list short sink-inputs | while read stream; do
		# 'read' removes TABS
    stream_id=$(echo $stream | cut -d' ' -f1)
    pacmd move-sink-input $stream_id $sink
	done
	
	(($VOL)) && pactl set-sink-volume $sink $vol
}


TYPE=$(get_type)
case $1 in
	toggle)
		# HP => SP
		if [[ $TYPE = $HP ]]; then
			swap_sink $SSINK 100%

			echo $SP > $TMP

		# SP => HP
		else
			swap_sink $HSINK 50%

			echo $HP > $TMP
		fi
		;;
	*)
		echo $TYPE | tee $TMP
		
		# watch file for changes
		while inotifywait -qe modify $TMP > /dev/null; do
			cat $TMP
		done
esac
