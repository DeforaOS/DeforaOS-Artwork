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
#executables
CONVERT="convert -quiet"
MKDIR="mkdir -p"
RM="rm -f"


#functions
#convert
_convert()
{
	theme="$1"
	size="${2}x${2}"
	folder="$theme/$size"
	shift 2

	$MKDIR "$folder/places"
	$CONVERT -background none \
		"../data/DeforaOS-d-black.svg" \
		-resize "$size" $@ \
		"$folder/places/start-here.png"			|| return 2
	return 0
}


#clean
_clean()
{
	theme="$1"
	size="${2}x${2}"
	folder="$theme/$size"

	$RM -- "$folder/places/start-here.png"			|| return 2
	return 0
}


#usage
_usage()
{
	echo "Usage: convert.sh [-c][-P prefix] target..." 1>&2
	return 1
}


#main
clean=0
while getopts "cP:" name; do
	case "$name" in
		c)
			clean=1
			;;
		P)
			#we can ignore it
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

	#clean
	if [ $clean -ne 0 ]; then
		_clean "$theme" "$size"				|| exit 2
		continue
	fi

	#create
	_convert "$theme" "$size"				|| exit 2
done
