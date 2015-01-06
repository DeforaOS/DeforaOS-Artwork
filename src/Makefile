TARGETS	= $(OBJDIR)DeforaOS/16x16/places/start-here.png $(OBJDIR)DeforaOS/22x22/places/start-here.png $(OBJDIR)DeforaOS/24x24/places/start-here.png $(OBJDIR)DeforaOS/32x32/places/start-here.png $(OBJDIR)DeforaOS/48x48/places/start-here.png $(OBJDIR)DeforaOS/256x256/places/start-here.png $(OBJDIR)DeforaOS/index.theme
OBJDIR	=
PREFIX	= /usr/local
DESTDIR	=
RM	= rm -f
LN	= ln -f
MKDIR	= mkdir -m 0755 -p
INSTALL	= install


all: $(TARGETS)

$(OBJDIR)DeforaOS/16x16/places/start-here.png:
	./convert.sh -P "$(PREFIX)" -- "$(OBJDIR)DeforaOS/16x16/places/start-here.png"

$(OBJDIR)DeforaOS/22x22/places/start-here.png:
	./convert.sh -P "$(PREFIX)" -- "$(OBJDIR)DeforaOS/22x22/places/start-here.png"

$(OBJDIR)DeforaOS/24x24/places/start-here.png:
	./convert.sh -P "$(PREFIX)" -- "$(OBJDIR)DeforaOS/24x24/places/start-here.png"

$(OBJDIR)DeforaOS/32x32/places/start-here.png:
	./convert.sh -P "$(PREFIX)" -- "$(OBJDIR)DeforaOS/32x32/places/start-here.png"

$(OBJDIR)DeforaOS/48x48/places/start-here.png:
	./convert.sh -P "$(PREFIX)" -- "$(OBJDIR)DeforaOS/48x48/places/start-here.png"

$(OBJDIR)DeforaOS/256x256/places/start-here.png:
	./convert.sh -P "$(PREFIX)" -- "$(OBJDIR)DeforaOS/256x256/places/start-here.png"

$(OBJDIR)DeforaOS/index.theme:
	./convert.sh -P "$(PREFIX)" -- "$(OBJDIR)DeforaOS/index.theme"

clean:
	$(RM) -- $(DeforaOS/16x16/places/start-here.png_OBJS) $(DeforaOS/22x22/places/start-here.png_OBJS) $(DeforaOS/24x24/places/start-here.png_OBJS) $(DeforaOS/32x32/places/start-here.png_OBJS) $(DeforaOS/48x48/places/start-here.png_OBJS) $(DeforaOS/256x256/places/start-here.png_OBJS) $(DeforaOS/index.theme_OBJS)
	./convert.sh -c -P "$(PREFIX)" -- "DeforaOS/16x16/places/start-here.png"
	./convert.sh -c -P "$(PREFIX)" -- "DeforaOS/22x22/places/start-here.png"
	./convert.sh -c -P "$(PREFIX)" -- "DeforaOS/24x24/places/start-here.png"
	./convert.sh -c -P "$(PREFIX)" -- "DeforaOS/32x32/places/start-here.png"
	./convert.sh -c -P "$(PREFIX)" -- "DeforaOS/48x48/places/start-here.png"
	./convert.sh -c -P "$(PREFIX)" -- "DeforaOS/256x256/places/start-here.png"
	./convert.sh -c -P "$(PREFIX)" -- "DeforaOS/index.theme"

distclean: clean
	$(RM) -- $(TARGETS)

install: $(TARGETS)
	./convert.sh -P "$(DESTDIR)$(PREFIX)/share/icons" -i -- "$(OBJDIR)DeforaOS/16x16/places/start-here.png"
	./convert.sh -P "$(DESTDIR)$(PREFIX)/share/icons" -i -- "$(OBJDIR)DeforaOS/22x22/places/start-here.png"
	./convert.sh -P "$(DESTDIR)$(PREFIX)/share/icons" -i -- "$(OBJDIR)DeforaOS/24x24/places/start-here.png"
	./convert.sh -P "$(DESTDIR)$(PREFIX)/share/icons" -i -- "$(OBJDIR)DeforaOS/32x32/places/start-here.png"
	./convert.sh -P "$(DESTDIR)$(PREFIX)/share/icons" -i -- "$(OBJDIR)DeforaOS/48x48/places/start-here.png"
	./convert.sh -P "$(DESTDIR)$(PREFIX)/share/icons" -i -- "$(OBJDIR)DeforaOS/256x256/places/start-here.png"
	./convert.sh -P "$(DESTDIR)$(PREFIX)/share/icons" -i -- "$(OBJDIR)DeforaOS/index.theme"

uninstall:
	./convert.sh -P "$(DESTDIR)$(PREFIX)/share/icons" -u -- "DeforaOS/16x16/places/start-here.png"
	./convert.sh -P "$(DESTDIR)$(PREFIX)/share/icons" -u -- "DeforaOS/22x22/places/start-here.png"
	./convert.sh -P "$(DESTDIR)$(PREFIX)/share/icons" -u -- "DeforaOS/24x24/places/start-here.png"
	./convert.sh -P "$(DESTDIR)$(PREFIX)/share/icons" -u -- "DeforaOS/32x32/places/start-here.png"
	./convert.sh -P "$(DESTDIR)$(PREFIX)/share/icons" -u -- "DeforaOS/48x48/places/start-here.png"
	./convert.sh -P "$(DESTDIR)$(PREFIX)/share/icons" -u -- "DeforaOS/256x256/places/start-here.png"
	./convert.sh -P "$(DESTDIR)$(PREFIX)/share/icons" -u -- "DeforaOS/index.theme"

.PHONY: all clean distclean install uninstall
