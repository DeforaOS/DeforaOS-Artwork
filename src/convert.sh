#!/bin/sh
#$Id$
#Copyright (c) 2014-2025 Pierre Pronchery <khorben@defora.org>
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
FONT="FontAwesome"
ICONS="
		actions/application-exit
		actions/appointment-new
		actions/appointment-soon
		actions/call-start
		actions/contact-new
		actions/document-new
		actions/document-open
		actions/document-open-recent
		actions/document-print
		actions/document-properties
		actions/document-revert
		actions/document-save
		actions/document-save-as
		actions/document-send
		actions/edit-clear
		actions/edit-copy
		actions/edit-cut
		actions/edit-delete
		actions/edit-find
		actions/edit-paste
		actions/edit-redo
		actions/edit-select-all
		actions/edit-undo
		actions/format-indent-less
		actions/format-indent-more
		actions/format-justify-center
		actions/format-justify-fill
		actions/format-justify-left
		actions/format-justify-right
		actions/format-text-bold
		actions/format-text-italic
		actions/format-text-strikethrough
		actions/format-text-underline
		actions/go-down
		actions/go-home
		actions/go-next
		actions/go-previous
		actions/go-up
		actions/help-about
		actions/help-contents
		actions/list-add
		actions/list-remove
		actions/mail-message-new
		actions/media-eject
		actions/media-playback-pause
		actions/media-playback-start
		actions/media-playback-stop
		actions/media-record
		actions/media-seek-forward
		actions/media-seek-backward
		actions/media-skip-backward
		actions/media-skip-forward
		actions/object-flip-horizontal
		actions/object-flip-vertical
		actions/object-rotate-left
		actions/object-rotate-right
		actions/process-stop
		actions/system-lock-screen
		actions/system-log-out
		actions/system-run
		actions/system-search
		actions/system-shutdown
		actions/view-fullscreen
		actions/view-refresh
		actions/view-sort-ascending
		actions/view-sort-descending
		actions/window-close
		actions/zoom-in
		actions/zoom-original
		actions/zoom-out
		apps/accessories-calculator
		apps/accessories-text-editor
		apps/help-browser
		apps/preferences-desktop-accessibility
		apps/preferences-desktop-font
		apps/preferences-desktop-locale
		apps/preferences-system-windows
		apps/system-file-manager
		apps/system-users
		apps/user-info
		apps/utilities-system-monitor
		apps/utilities-terminal
		apps/web-browser
		categories/applications-development
		categories/applications-engineering
		categories/applications-games
		categories/applications-graphics
		categories/applications-internet
		categories/applications-multimedia
		categories/applications-office
		categories/applications-science
		categories/applications-system
		categories/preferences-desktop
		devices/audio-input-microphone
		devices/camera-photo
		devices/camera-video
		devices/drive-harddisk
		devices/input-gaming
		devices/input-keyboard
		devices/drive-optical
		devices/media-optical
		devices/media-floppy
		devices/modem
		devices/network-wireless
		devices/phone
		devices/printer
		devices/video-display
		mimetypes/image-x-generic
		mimetypes/package-x-generic
		mimetypes/x-office-calendar
		places/folder
		places/folder-download
		places/folder-music
		places/folder-pictures
		places/folder-publicshare
		places/folder-videos
		places/network-workgroup
		places/user-bookmarks
		places/user-trash
		status/audio-volume-muted
		status/changes-allow
		status/changes-prevent
		status/dialog-error
		status/dialog-information
		status/dialog-password
		status/dialog-question
		status/dialog-warning
		status/folder-open
		status/image-loading
		status/mail-attachment
		status/network-idle
		status/network-receive
		status/network-transmit
		status/network-transmit-receive
		status/network-offline"
PREFIX="/usr/local"
IMGEXT=".png"
PROGNAME="convert.sh"
SYMLINKS="
accessories-calculator	apps/calc
accessories-calculator	apps/gnome-calculator
accessories-calculator	apps/kcalc
accessories-text-editor	apps/kedit
accessories-text-editor	apps/text-editor
application-exit	actions/exit
application-exit	actions/gtk-quit
application-exit	actions/xfce-system-exit
applications-development	categories/gnome-devel
applications-development	categories/package_development
applications-development	categories/redhat-programming
applications-games	categories/gnome-joystick
applications-games	categories/package_games
applications-games	categories/redhat-games
applications-games	categories/xfce-games
applications-graphics	categories/gnome-graphics
applications-graphics	categories/package_graphics
applications-graphics	categories/redhat_graphics
applications-graphics	categories/xfce-graphics
applications-internet	categories/gnome-globe
applications-internet	categories/package_network
applications-internet	categories/redhat-internet
applications-internet	categories/stock_internet
applications-internet	categories/xfce-internet
applications-multimedia	categories/gnome-multimedia
applications-multimedia	categories/package_multimedia
applications-multimedia	categories/redhat-sound_video
applications-multimedia	categories/xfce-multimedia
applications-office	categories/gnome-applications
applications-office	categories/package_office
applications-office	categories/redhat-office
applications-office	categories/xfce-office
applications-system	categories/gnome-system
applications-system	categories/package_system
applications-system	categories/redhat-system_tools
appointment-new		actions/appointment
appointment-new		actions/stock_new-appointment
appointment-soon	actions/stock_appointment-reminder
audio-input-microphone	devices/gnome-stock-mic
audio-input-microphone	devices/stock_mic
audio-volume-muted	status/stock_volume-mute
camera-photo		devices/camera
camera-photo		devices/camera_unmount
contact-new		actions/stock_new-bcard
dialog-error		status/gtk-dialog-error
dialog-error		status/stock_dialog-error
dialog-information	status/stock_dialog-info
dialog-information	status/stock_dialog-info
dialog-password		status/gtk-dialog-authentication
dialog-question		status/gtk-dialog-question
dialog-question		status/stock_dialog-question
dialog-warning		status/gtk-dialog-warning
dialog-warning		status/stock_dialog-warning
document-new		actions/gtk-new
document-open		actions/gtk-open
document-open		actions/fileopen
document-print		actions/fileprint
document-print		actions/gtk-print
document-print		actions/stock_print
document-properties	actions/gtk-properties
document-properties	actions/stock_properties
document-revert		actions/gtk-revert-to-saved-ltr
document-revert		actions/gtk-revert-to-saved-rtl
document-revert		actions/revert
document-save		actions/filesave
document-save		actions/gtk-save
document-save		actions/stock_save
document-save-as	actions/filesaves
document-save-as	actions/gtk-save-as
document-save-as	actions/stock_save-as
drive-harddisk		devices/gnome-dev-harddisk
drive-harddisk		devices/gnome-dev-harddisk-1394
drive-harddisk		devices/gnome-dev-harddisk-usb
drive-harddisk		devices/gtk-harddisk
drive-harddisk		devices/harddrive
drive-harddisk		devices/hdd_unmount
drive-harddisk		devices/yast_HD
drive-harddisk		devices/yast_idetude
drive-optical		devices/drive-cdrom
drive-optical		devices/gnome-dev-cdrom
drive-optical		devices/gnome-dev-dvd
edit-clear		actions/editclear
edit-clear		actions/gtk-clear
edit-copy		actions/editcopy
edit-copy		actions/gtk-copy
edit-copy		actions/stock_copy
edit-cut		actions/editcut
edit-cut		actions/gtk-cut
edit-cut		actions/stock_cut
edit-delete		actions/editdelete
edit-delete		actions/gtk-delete
edit-delete		actions/stock_delete
edit-find		actions/filefind
edit-find		actions/find
edit-find		actions/gtk-find
edit-find		actions/stock_search
edit-paste		actions/editpaste
edit-paste		actions/gtk-paste
edit-paste		actions/stock_paste
edit-redo		actions/gtk-redo-ltr
edit-redo		actions/redo
edit-redo		actions/stock_redo
edit-select-all		actions/gtk-select-all
edit-select-all		actions/stock_select-all
edit-undo		actions/gtk-undo-ltr
edit-undo		actions/stock_undo
edit-undo		actions/undo
folder			places/gtk-directory
folder			places/inode-directory
folder			places/stock_folder
folder-open		status/folder_open
folder-open		status/stock_open
format-indent-less	actions/gnome-stock-text-unindent
format-indent-less	actions/gtk-indent-rtl
format-indent-less	actions/gtk-unindent-ltr
format-indent-less	actions/stock_text_unindent
format-indent-more	actions/gnome-stock-text-indent
format-indent-more	actions/gtk-indent-ltr
format-indent-more	actions/gtk-unindent-rtl
format-indent-more	actions/stock_text_indent
format-justify-center	actions/centerjust
format-justify-center	actions/gtk-justify-center
format-justify-center	actions/stock_text_center
format-justify-fill	actions/gtk-justify-fill
format-justify-fill	actions/stock_text_justify
format-justify-left	actions/gtk-justify-left
format-justify-left	actions/leftjust
format-justify-left	actions/stock_text_left
format-justify-right	actions/gtk-justify-right
format-justify-right	actions/rightjust
format-justify-right	actions/stock_text_right
format-text-bold	actions/gtk-bold
format-text-bold	actions/stock_text_bold
format-text-bold	actions/text_bold
format-text-italic	actions/gtk-italic
format-text-italic	actions/stock_text_italic
format-text-italic	actions/text_italic
format-text-strikethrough	actions/gtk-strikethrough
format-text-strikethrough	actions/stock_text_strikethrough
format-text-strikethrough	actions/text_strike
format-text-underline	actions/gtk-underline
format-text-underline	actions/stock_text_underline
format-text-underline	actions/text_underline
go-down			actions/gtk-go-down
go-down			actions/stock_down
go-down			actions/down
go-home			actions/gohome
go-home			actions/gtk-home
go-home			actions/kfm_home
go-home			actions/redhat-home
go-home			actions/stock_home
go-next			actions/forward
go-next			actions/gtk-go-back-rtl
go-next			actions/gtk-go-forward-ltr
go-next			actions/next
go-next			actions/stock_right
go-previous		actions/back
go-previous		actions/gtk-go-back-ltr
go-previous		actions/gtk-go-forward-rtl
go-previous		actions/previous
go-previous		actions/stock_left
go-up			actions/gtk-go-up
go-up			actions/stock_up
go-up			actions/up
help-about		actions/gtk-about
help-about		actions/stock_about
help-browser		apps/gnome-help
help-browser		apps/khelpcenter
help-browser		apps/susehelpcenter
help-contents		actions/help
help-contents		actions/stock_help
image-loading		status/gnome-fs-loading-icon
image-x-generic		mimetypes/gnome-mime-image
image-x-generic		mimetypes/image
input-gaming		devices/joystick
input-gaming		devices/yast_joystick
input-keyboard		devices/gnome-dev-keyboard
input-keyboard		devices/keyboard
input-keyboard		devices/kxkb
input-keyboard		devices/xfce4-keyboard
list-add		actions/add
list-add		actions/gtk-add
list-remove		actions/remove
list-remove		actions/gtk-remove
mail-attachment		status/stock_attach
mail-message-new	actions/gnome-stock-mail-new
mail-message-new	actions/mail_new
mail-message-new	actions/stock_mail-compose
media-eject		actions/player_eject
media-floppy		devices/3floppy_unmount
media-floppy		devices/gnome-dev-floppy
media-floppy		devices/gtk-floppy
media-floppy		devices/system-floppy
media-optical		devices/cdrom_unmount
media-optical		devices/cdwriter_unmount
media-optical		devices/dvd_unmount
media-optical		devices/gnome-dev-cdrom-audio
media-optical		devices/gnome-dev-disc-cdr
media-optical		devices/gnome-dev-disc-cdrw
media-optical		devices/gnome-dev-disc-dvdr
media-optical		devices/gnome-dev-disc-dvdr-plus
media-optical		devices/gnome-dev-disc-dvdram
media-optical		devices/gnome-dev-disc-dvdrom
media-optical		devices/gnome-dev-disc-dvdrw
media-optical		devices/gtk-cdrom
media-optical		devices/media-cdrom
media-playback-pause	actions/gtk-media-pause
media-playback-pause	actions/player_pause
media-playback-pause	actions/stock_media-pause
media-playback-start	actions/gtk-media-play-ltr
media-playback-start	actions/player_play
media-playback-start	actions/stock_media-play
media-playback-stop	actions/gtk-media-stop
media-playback-stop	actions/player_stop
media-record		actions/gtk-media-record
media-record		actions/player_record
media-record		actions/stock_media-rec
media-seek-backward	actions/gtk-media-rewind-ltr
media-seek-backward	actions/player_rew
media-seek-backward	actions/stock_media-rew
media-seek-forward	actions/gtk-media-forward-ltr
media-seek-forward	actions/player_fwd
media-seek-forward	actions/stock_media-fwd
modem			devices/gnome-modem
network-idle		status/connect_established
network-idle		status/gnome-netstatus-idle
network-idle		status/nm-adhoc
network-idle		status/nm-device-wired
network-idle		status/nm-device-wireless
network-receive		status/gnome-netstatus-rx
network-transmit	status/gnome-netstatus-tx
network-transmit-receive	status/connect_creating
network-transmit-receive	status/gnome-netstatus-txrx
network-offline		status/connect_no
network-offline		status/gnome-netstatus-disconn
network-offline		status/nm-no-connection
network-wireless	devices/gnome-dev-wavelan
network-workgroup	places/gnome-fs-network
network-workgroup	places/gnome-mime-x-directory-smb-workgroup
network-workgroup	places/gtk-network
network-workgroup	places/network_local
package-x-generic	mimetypes/gnome-package
package-x-generic	mimetypes/package
phone			devices/stock_cell-phone
preferences-desktop	categories/gnome-control-center
preferences-desktop	categories/gnome-settings
preferences-desktop	categories/gtk-preferences
preferences-desktop	categories/kcontrol
preferences-desktop	categories/redhat-preferences
preferences-desktop	categories/xfce4-settings
preferences-desktop-accessibility	apps/access
preferences-desktop-accessibility	apps/accessibility-directory
preferences-desktop-accessibility	apps/gnome-settings-accessibility-technologies
preferences-desktop-font	apps/fonts
preferences-desktop-font	apps/gnome-settings-font
preferences-desktop-locale	apps/config-language
preferences-desktop-locale	apps/locale
preferences-system-windows	apps/gnome-window-manager
preferences-system-windows	apps/kcmkwm
preferences-system-windows	apps/kwin
preferences-system-windows	apps/xfwm4
printer			devices/gnome-dev-printer
printer			devices/printer-remote
printer			devices/printer1
printer			devices/printmgr
printer			devices/stock_printers
printer			devices/xfce-printer
printer			devices/yast_printer
process-stop		actions/gtk-cancel
process-stop		actions/gtk-stop
process-stop		actions/stock_stop
process-stop		actions/stop
system-file-manager	apps/file-manager
system-file-manager	apps/kfm
system-file-manager	apps/redhat-filemanager
system-file-manager	apps/xfce-filemanager
system-lock-screen	actions/gnome-lockscreen
system-lock-screen	actions/lock
system-lock-screen	actions/xfce-system-lock
system-log-out		actions/gnome-logout
system-run		actions/gnome-run
system-run		actions/gtk-execute
system-search		actions/edit-find
system-search		actions/gnome-searchtool
system-search		actions/kfind
system-search		actions/search
system-shutdown		actions/gnome-shutdown
system-users		apps/config-users
system-users		apps/kuser
system-users		apps/system-config-users
user-trash		places/emptytrash
user-trash		places/gnome-fs-trash-empty
user-trash		places/gnome-stock-trash
user-trash		places/trashcan_empty
user-trash		places/xfce-trash_empty
utilities-system-monitor	apps/gnome-monitor
utilities-system-monitor	apps/ksysguard
utilities-terminal	apps/gnome-terminal
utilities-terminal	apps/konsole
utilities-terminal	apps/openterm
utilities-terminal	apps/terminal
utilities-terminal	apps/xfce-terminal
video-display		devices/chardevice
video-display		devices/display
video-display		devices/xfce4-display
view-fullscreen		actions/gtk-fullscreen
view-fullscreen		actions/stock_fullscreen
view-fullscreen		actions/window_fullscreen
view-refresh		actions/gtk-refresh
view-refresh		actions/stock_refresh
view-sort-ascending	actions/gtk-sort-ascending
view-sort-descending	actions/gtk-sort-descending
window-close		actions/gtk-close
window-close		actions/stock_close
x-office-calendar	mimetypes/gnome-mime-text-x-vcalendar
x-office-calendar	mimetypes/plan
x-office-calendar	mimetypes/stock_calendar
x-office-calendar	mimetypes/vcalendar
zoom-in			actions/gtk-zoom-in
zoom-in			actions/stock_zoom-in
zoom-in			actions/viewmag+
zoom-original		actions/gtk-zoom-100
zoom-original		actions/stock_zoom-1
zoom-original		actions/viewmag1
zoom-out		actions/gtk-zoom-out
zoom-out		actions/stock_zoom-out
zoom-out		actions/viewmag-"
THEMEEXT=".theme"
[ -f "../config.sh" ] && . "../config.sh"
#executables
CONVERT="convert"
DEBUG="_debug"
FIND="find"
GM="gm"
GMORIM="_gmorim"
INSTALL="install -m 0644"
LN="ln -f"
MAGICK="magick"
MKDIR="mkdir -m 0755 -p"
RM="rm -f"
SORT="sort"


#functions
#convert
_convert()
{
	theme="$1"
	size="${2}x${2}"
	folder="$theme/$size"
	shift 2

	$DEBUG $MKDIR -- "$OBJDIR$folder/places"		|| return 2
	$GMORIM $CONVERT -background none -density 300 \
		"../data/DeforaOS-d-${BGCOLOR}.svg" \
		-resize "$size" $@ \
		"$OBJDIR$folder/places/start-here$IMGEXT"	|| return 2

	#icons
	echo "$ICONS" | while read char stock; do
		[ -z "$char" ] && continue
		dirname="${stock%/*}"

		$DEBUG $MKDIR -- "$OBJDIR$folder/$dirname"	|| return 2
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
		gravity Center
		text 0,0 '$char'
	pop graphic-context
pop graphic-context" | $GMORIM $CONVERT -background none mvg:- \
		-resize "$size" $@ \
		"$OBJDIR$folder/${stock}$IMGEXT"		|| return 2
	done
	[ $? -eq 0 ]						|| return 2

	#symlinks
	echo "$SYMLINKS" | while read from to; do
		[ -z "$from" ] && continue

		$DEBUG $LN -s -- "${from}$IMGEXT" "$OBJDIR$folder/${to}$IMGEXT" \
								|| return 2
	done
	[ $? -eq 0 ]						|| return 2
}


#clean
_clean()
{
	theme="$1"
	size="${2}x${2}"
	folder="$theme/$size"

	$DEBUG $RM -- "$OBJDIR$folder/places/start-here$IMGEXT"	|| return 2

	#icons
	echo "$ICONS" | while read char stock; do
		[ -z "$char" ] && continue

		$DEBUG $RM -- "$OBJDIR$theme/${size}/${stock}$IMGEXT" \
								|| return 2
	done

	#symlinks
	echo "$SYMLINKS" | while read from to; do
		[ -z "$from" ] && continue

		$DEBUG $RM -- "$OBJDIR$theme/${size}/${to}$IMGEXT" \
								|| return 2
	done
}


#gmorim
_gmorim()
{
	$DEBUG $GM "$@"
	ret=$?
	if [ $ret -eq 127 ]; then
		$DEBUG $MAGICK "$@"
		ret=$?
	fi
	return $ret
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
	$FIND "$OBJDIR$theme" -type d | $SORT | while read folder; do
		folder="${folder#$OBJDIR}"
		size="${folder#*/}"
		size="${size%%/*}"
		basename="${folder##*/}"

		[ "$size" != "$basename" ] || continue
		echo -n "$sep${size}/$basename"
		sep=","
	done
	echo ""

	#directories
	$FIND "$OBJDIR$theme" -type d | $SORT | while read folder; do
		folder="${folder#$OBJDIR}"
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
	$DEBUG $INSTALL "$OBJDIR$target" "$PREFIX/$target"	|| return 2
	[ -z "$size" ] && return 0

	#icons
	echo "$ICONS" | while read char stock; do
		[ -z "$char" ] && continue
		dirname="${stock%/*}"

		$DEBUG $MKDIR -- "$PREFIX/$instdir/${size}x${size}/$dirname" \
								|| return 2
		$DEBUG $INSTALL "$OBJDIR$instdir/${size}x${size}/${stock}$IMGEXT" \
			"$PREFIX/$instdir/${size}x${size}/${stock}$IMGEXT" \
								|| return 2
	done

	#symlinks
	echo "$SYMLINKS" | while read from to; do
		[ -z "$from" ] && continue

		$DEBUG $LN -s -- "${from}$IMGEXT" \
			"$PREFIX/$instdir/${size}x${size}/${to}$IMGEXT" \
								|| return 2
	done
}


#uninstall
_uninstall()
{
	target="$1"
	size="$2"
	instdir="${target%%/*}"

	$DEBUG $RM -- "$PREFIX/$target"				|| return 2
	[ -z "$size" ] && return 0

	#icons
	echo "$ICONS" | while read char stock; do
		[ -z "$char" ] && continue

		$DEBUG $RM -- "$PREFIX/$instdir/${size}x${size}/${stock}$IMGEXT" \
								|| return 2
	done

	#symlinks
	echo "$SYMLINKS" | while read from to; do
		[ -z "$from" ] && continue

		$DEBUG $RM -- "$PREFIX/$instdir/${size}x${size}/${to}$IMGEXT" \
								|| return 2
	done
}


#usage
_usage()
{
	echo "Usage: $PROGNAME [-c|-i|-u][-P prefix] target..." 1>&2
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
	target="${1#$OBJDIR}"
	shift

	#determine the argument
	theme="${target%%/*}"
	index="${target#*/}"
	size="${index%%/*}"
	size="${size%%x*}"
	filename="${target##*/}"

	#clean
	if [ $clean -ne 0 ]; then
		if [ "$filename" = "index$THEMEEXT" ]; then
			$DEBUG $RM -- "$theme/index$THEMEEXT"	|| exit 2
		else
			_clean "$theme" "$size"			|| exit 2
		fi
		continue
	fi

	#uninstall
	if [ $uninstall -eq 1 ]; then
		if [ "$filename" = "index$THEMEEXT" ]; then
			_uninstall "$target"			|| exit 2
		else
			_uninstall "$target" "$size"		|| exit 2
		fi
		continue
	fi

	#install
	if [ $install -eq 1 ]; then
		if [ "$filename" = "index$THEMEEXT" ]; then
			_install "$target"			|| exit 2
		else
			_install "$target" "$size"		|| exit 2
		fi
		continue
	fi

	#create
	if [ "$filename" = "index$THEMEEXT" ]; then
		$DEBUG $MKDIR -- "$OBJDIR$theme"		|| exit 2
		_index "$theme" > "$OBJDIR$theme/index$THEMEEXT"|| exit 2
	else
		_convert "$theme" "$size"			|| exit 2
	fi
done
