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
PREFIX="/usr/local"
[ -f "../config.sh" ] && . "../config.sh"
#executables
CONVERT="convert -quiet"
DEBUG="_debug"
FIND="find"
INSTALL="install -m 0644"
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
		"../data/DeforaOS-d-black.svg" \
		-resize "$size" $@ \
		"$folder/places/start-here.png"			|| return 2
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

	echo "[Icon Theme]"
	echo "Name=$theme"
	echo "Example=start-here"

	echo -n "Directories="
	sep=
	$FIND "$theme" -type d | while read folder; do
		theme="${folder%%/*}"
		size="${folder#*/}"
		size="${size%%/*}"
		size="${size%%x*}"
		basename="${folder##*/}"

		[ "$basename" = "places" ] || continue
		echo -n "$sep$folder"
		sep=","
	done
	echo ""

	$FIND "$theme" -type d | while read folder; do
		theme="${folder%%/*}"
		size="${folder#*/}"
		size="${size%%/*}"
		size="${size%%x*}"
		basename="${folder##*/}"

		[ "$basename" = "places" ] || continue
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
	instdir="${target%/*}"

	$DEBUG $MKDIR -- "$PREFIX/$instdir"			|| return 2
	$DEBUG $INSTALL "$target" "$PREFIX/$target"		|| return 2
}


#uninstall
_uninstall()
{
	target="$1"
	instdir="${target%/*}"

	$DEBUG $RM "$PREFIX/$target"				|| return 2
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
		_uninstall "$target"				|| exit 2
		continue
	fi

	#install
	if [ $install -eq 1 ]; then
		_install "$target"				|| exit 2
		continue
	fi

	#create
	if [ "$filename" = "index.theme" ]; then
		_index "$theme" > "$theme/index.theme"		|| exit 2
	else
		_convert "$theme" "$size"			|| exit 2
	fi
done
