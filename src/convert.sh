#!/bin/sh
#$Id$
#Copyright (c) 2014 Pierre Pronchery <khorben@defora.org>
#This file is part of DeforaOS Artwork
#Redistribution and use in source and binary forms, with or without
#modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
#FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
#DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
#SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
#CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
#OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
#OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.



#variables
BGCOLOR="black"
FGCOLOR="white"
FONT='DejaVu Sans'
ICONS="
ø		actions/edit-clear
↷		actions/edit-redo
↶		actions/edit-undo
↓		actions/go-down
→		actions/go-next
←		actions/go-previous
↑		actions/go-up
⏏		actions/media-eject
►		actions/media-playback-start
■		actions/media-playback-stop
⨯		actions/process-stop
↻		actions/view-refresh
+		actions/zoom-in
1		actions/zoom-original
-		actions/zoom-out"
PREFIX="/usr/local"
SYMLINKS="
edit-clear	actions/editclear
edit-clear	actions/gtk-clear
edit-redo	actions/gtk-redo-ltr
edit-redo	actions/redo
edit-redo	actions/stock_redo
edit-undo	actions/gtk-undo-ltr
edit-undo	actions/stock_undo
edit-undo	actions/undo
go-next		actions/forward
go-next		actions/gtk-go-back-rtl
go-next		actions/gtk-go-forward-ltr
go-next		actions/next
go-next		actions/stock_right
go-previous	actions/back
go-previous	actions/gtk-go-back-ltr
go-previous	actions/gtk-go-forward-rtl
go-previous	actions/previous
go-previous	actions/stock_left
media-eject	actions/player_eject
media-playback-start	actions/gtk-media-play-ltr
media-playback-start	actions/player_play
media-playback-start	actions/stock_media-play
media-playback-stop	actions/gtk-media-stop
media-playback-stop	actions/player_stop
process-stop	actions/gtk-cancel
process-stop	actions/gtk-stop
process-stop	actions/stock_stop
process-stop	actions/stop
view-refresh	actions/gtk-refresh
view-refresh	actions/stock_refresh
zoom-in		actions/gtk-zoom-in
zoom-original	actions/gtk-zoom-100
zoom-out	actions/gtk-zoom-out
zoom-in		actions/stock_zoom-in
zoom-original	actions/stock_zoom-1
zoom-out	actions/stock_zoom-out"
[ -f "../config.sh" ] && . "../config.sh"
#executables
CONVERT="convert -quiet"
DEBUG="_debug"
FIND="find"
INSTALL="install -m 0644"
LN="ln -f"
MKDIR="mkdir -m 0755 -p"
RM="rm -f"


#functions
#convert
_convert()
{
	theme="$1"
	size="${2}x${2}"
	folder="$theme/$size"
	shift 2

	$DEBUG $MKDIR "$folder/places"
	$DEBUG $CONVERT -background none -density 300 \
		"../data/DeforaOS-d-${BGCOLOR}.svg" \
		-resize "$size" $@ \
		"$folder/places/start-here.png"			|| return 2

	#icons
	echo "$ICONS" | while read char stock; do
		[ -z "$char" ] && continue
		dirname="${stock%/*}"

		$DEBUG $MKDIR "$folder/$dirname"
		echo "push graphic-context
	viewbox 0 0 256 256
	push graphic-context
		fill '$BGCOLOR'
		circle 128,128 127,255
	pop graphic-context
	push graphic-context
		fill '$FGCOLOR'
		font-family '$FONT'
		font-size 224
		text 32,196 '$char'
	pop graphic-context
pop graphic-context" | $DEBUG $CONVERT -background none - \
		-resize "$size" $@ \
		"$folder/${stock}.png"				|| return 2
	done

	#symlinks
	echo "$SYMLINKS" | while read from to; do
		[ -z "$from" ] && continue

		$DEBUG $LN -s "${from}.png" "$folder/${to}.png"	|| return 2
	done
}


#clean
_clean()
{
	theme="$1"
	size="${2}x${2}"
	folder="$theme/$size"

	$DEBUG $RM -- "$folder/places/start-here.png"		|| return 2
}


#debug
_debug()
{
	echo "$@" 1>&2
	"$@"
}


#index
_index()
{
	theme="$1"

	#icon theme
	echo "[Icon Theme]"
	echo "Name=$theme"
	echo "Comment=$theme icon theme"
	echo "Example=start-here"

	echo -n "Directories="
	sep=
	$FIND "$theme" -type d | while read folder; do
		size="${folder#*/}"
		size="${size%%/*}"
		basename="${folder##*/}"

		[ "$size" != "$basename" ] || continue
		echo -n "$sep${size}/$basename"
		sep=","
	done
	echo ""

	#directories
	$FIND "$theme" -type d | while read folder; do
		size="${folder#*/}"
		size="${size%%/*}"
		basename="${folder##*/}"

		[ "$size" != "$basename" ] || continue
		size="${size%x*}"
		echo ""
		echo "[${size}x${size}/$basename]"
		echo "Size=$size"
		echo "Context=Places"
		echo "Type=Fixed"
	done
}


#install
_install()
{
	target="$1"
	size="$2"
	dirname="${target%/*}"
	instdir="${target%%/*}"

	$DEBUG $MKDIR -- "$PREFIX/$dirname"			|| return 2
	$DEBUG $INSTALL "$target" "$PREFIX/$target"		|| return 2
	[ -z "$size" ] && return 0

	#icons
	echo "$ICONS" | while read char stock; do
		[ -z "$char" ] && continue
		dirname="${stock%/*}"

		$DEBUG $MKDIR -- "$PREFIX/$instdir/${size}x${size}/$dirname" \
								|| return 2
		$DEBUG $INSTALL "$instdir/${size}x${size}/${stock}.png" \
			"$PREFIX/$instdir/${size}x${size}/${stock}.png" \
								|| return 2
	done

	#symlinks
	echo "$SYMLINKS" | while read from to; do
		[ -z "$from" ] && continue

		$DEBUG $LN -s "${from}.png" \
			"$PREFIX/$instdir/${size}x${size}/${to}.png" \
								|| return 2
	done
}


#uninstall
_uninstall()
{
	target="$1"
	size="$2"
	instdir="${target%%/*}"

	$DEBUG $RM "$PREFIX/$target"				|| return 2
	[ -z "$size" ] && return 0

	#icons
	echo "$ICONS" | while read char stock; do
		[ -z "$char" ] && continue

		$DEBUG $RM "$PREFIX/$instdir/${size}x${size}/${stock}.png" \
								|| return 2
	done

	#symlinks
	echo "$SYMLINKS" | while read from to; do
		[ -z "$from" ] && continue

		$DEBUG $RM "$PREFIX/$instdir/${size}x${size}/${to}.png" \
								|| return 2
	done
}


#usage
_usage()
{
	echo "Usage: convert.sh [-c|-i|-u][-P prefix] target..." 1>&2
	return 1
}


#main
clean=0
install=0
uninstall=0
while getopts "ciuP:" name; do
	case "$name" in
		c)
			clean=1
			;;
		i)
			install=1
			uninstall=0
			;;
		u)
			install=0
			uninstall=1
			;;
		P)
			PREFIX="$OPTARG"
			;;
		?)
			_usage
			exit $?
			;;
	esac
done
shift $((OPTIND - 1))
if [ $# -eq 0 ]; then
	_usage
	exit $?
fi

while [ $# -gt 0 ]; do
	target="$1"
	shift

	#determine the argument
	theme="${target%%/*}"
	size="${target#*/}"
	size="${size%%/*}"
	size="${size%%x*}"
	filename="${target##*/}"

	#clean
	if [ $clean -ne 0 ]; then
		_clean "$theme" "$size"				|| exit 2
		continue
	fi

	#uninstall
	if [ $uninstall -eq 1 ]; then
		if [ "$filename" = "index.theme" ]; then
			_uninstall "$target"			|| exit 2
		else
			_uninstall "$target" "$size"		|| exit 2
		fi
		continue
	fi

	#install
	if [ $install -eq 1 ]; then
		if [ "$filename" = "index.theme" ]; then
			_install "$target"			|| exit 2
		else
			_install "$target" "$size"		|| exit 2
		fi
		continue
	fi

	#create
	if [ "$filename" = "index.theme" ]; then
		_index "$theme" > "$theme/index.theme"		|| exit 2
	else
		_convert "$theme" "$size"			|| exit 2
	fi
done
