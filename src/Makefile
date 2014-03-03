TARGETS	= DeforaOS/16x16/places/start-here.png DeforaOS/22x22/places/start-here.png DeforaOS/24x24/places/start-here.png DeforaOS/32x32/places/start-here.png DeforaOS/48x48/places/start-here.png DeforaOS/256x256/places/start-here.png
PREFIX	= /usr/local
DESTDIR	=
RM	= rm -f
LN	= ln -f
MKDIR	= mkdir -m 0755 -p
INSTALL	= install


all: $(TARGETS)

DeforaOS/16x16/places/start-here.png:
	./convert.sh -P "$(PREFIX)" -- "DeforaOS/16x16/places/start-here.png"

DeforaOS/22x22/places/start-here.png:
	./convert.sh -P "$(PREFIX)" -- "DeforaOS/22x22/places/start-here.png"

DeforaOS/24x24/places/start-here.png:
	./convert.sh -P "$(PREFIX)" -- "DeforaOS/24x24/places/start-here.png"

DeforaOS/32x32/places/start-here.png:
	./convert.sh -P "$(PREFIX)" -- "DeforaOS/32x32/places/start-here.png"

DeforaOS/48x48/places/start-here.png:
	./convert.sh -P "$(PREFIX)" -- "DeforaOS/48x48/places/start-here.png"

DeforaOS/256x256/places/start-here.png:
	./convert.sh -P "$(PREFIX)" -- "DeforaOS/256x256/places/start-here.png"

clean:
	$(RM) -- $(DeforaOS/16x16/places/start-here.png_OBJS) $(DeforaOS/22x22/places/start-here.png_OBJS) $(DeforaOS/24x24/places/start-here.png_OBJS) $(DeforaOS/32x32/places/start-here.png_OBJS) $(DeforaOS/48x48/places/start-here.png_OBJS) $(DeforaOS/256x256/places/start-here.png_OBJS)
	./convert.sh -c -P "$(PREFIX)" -- "DeforaOS/256x256/places/start-here.png"

distclean: clean
	$(RM) -- $(TARGETS)

install: $(TARGETS)

uninstall:

.PHONY: all clean distclean install uninstall
