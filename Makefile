prefix=/usr/local
bindir=${prefix}/bin
mandir=${prefix}/share/man
man1dir=${mandir}/man1

TARGETS=gits.1 README gits
JUNK=gits.1 checkdir

all: $(TARGETS)

gits.1: gits
	pod2man < $^ > $@

gits-checkup.1: gits-checkup
	pod2man < $^ > $@

install: $(TARGETS)
	mkdir -p $(DESTDIR)/$(man1dir) $(DESTDIR)/$(bindir)
	install -m 444 gits.1 $(DESTDIR)/$(man1dir)
	VERSION=`./gits --version`; \
	 sed "s/{UNTAGGED}/$${VERSION}/" gits > $(DESTDIR)/$(bindir)/gits
	chmod 755 $(DESTDIR)/$(bindir)/gits
	@perl -MTerm::ProgressBar -e 1 >/dev/null 2>&1 || echo Warning: Missing optional Term::ProgressBar
	@perl -MParallel::Iterator -e 1 >/dev/null 2>&1 || echo Warning: Missing optional Parallel::Iterator package

README: gits
	pod2text < gits > README

release:
	VERSION=`git describe --match 'v[0-9]*' | sed 's/^v//'`; git checkout-index -a -f --prefix=/tmp/gitslave-$$VERSION/; cd /tmp; tar czf gitslave-$$VERSION.tar.gz gitslave-$$VERSION; rm -rf /tmp/gitslave-$$VERSION; echo /tmp/gitslave-$$VERSION.tar.gz

clean nuke:
	rm -rf $(JUNK) *~ core* \#*
	(cd contrib; make $@)

check test: clean
	./prep_gitscheck
