prefix=/usr/local
bindir=${prefix}/bin
mandir=${prefix}/share/man
man1dir=${mandir}/man1

TARGETS=gits-checkup.1 gitin.1
JUNK=gits-checkup.1 gitin.1

all: $(TARGETS)

%.1: %
	pod2man < $^ > $@

install: $(TARGETS)
	mkdir -p $(DESTDIR)/$(man1dir) $(DESTDIR)/$(bindir)
	install -m 444 gits-checkup.1 $(DESTDIR)/$(man1dir)
	install -m 444 gitin.1 $(DESTDIR)/$(man1dir)
	install -m 444 gitin.1 $(DESTDIR)/$(man1dir)/gitout.1
	install -m 755 gits-checkup $(DESTDIR)/$(bindir)
	install -m 755 gitin $(DESTDIR)/$(bindir)/
	install -m 755 gitin $(DESTDIR)/$(bindir)/gitout

clean nuke:
	rm -rf $(JUNK) *~ core* \#*
