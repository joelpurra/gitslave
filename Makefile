prefix=/usr/local
bindir=${prefix}/bin
mandir=${prefix}/share/man
man1dir=${mandir}/man1

TARGETS=gits.1 README gits contrib/gitslave.spec webtargets contribtargets
JUNK=gits.1 checkdir contrib/gitslave.spec

all: $(TARGETS)

gits.1: gits
	pod2man < $^ > $@

gits-checkup.1: gits-checkup
	pod2man < $^ > $@

contrib/gitslave.spec: contrib/gitslave.spec.in
	if [ -d .git ]; then							\
	  VERSION=`./gits --version`;						\
	  sed "s/{UNTAGGED}/$${VERSION}/" <$^ > $@;				\
	fi

install: $(TARGETS)
	mkdir -p $(DESTDIR)/$(man1dir) $(DESTDIR)/$(bindir)
	install -m 444 gits.1 $(DESTDIR)/$(man1dir)
	if [ -d .git ]; then							\
	  VERSION=`./gits --version`;						\
	  sed "s/{UNTAGGED}/$${VERSION}/" gits > $(DESTDIR)/$(bindir)/gits;	\
	  chmod 755 $(DESTDIR)/$(bindir)/gits;					\
	else									\
	  install -m 755 gits $(DESTDIR)/$(bindir)/;				\
	fi
	@perl -MTerm::ProgressBar -e 1 >/dev/null 2>&1 || echo Warning: Missing optional Term::ProgressBar
	@perl -MParallel::Iterator -e 1 >/dev/null 2>&1 || echo Warning: Missing optional Parallel::Iterator package
	@echo Consider: "make install -C contrib"

README: gits
	pod2text < gits > README

release: README
	@VERSION=`git describe --exact-match --match 'v[0-9]*' 2>/dev/null | sed 's/^v//'`;					\
	  if [ $$? -ne 0 -o "$$VERSION" = "" ]; then echo "Not a tagged version, you may not release"; exit 3; fi;		\
	  if [ `git status --porcelain | wc -l` -gt 0 ]; then echo "Uncommitted changes, you may not release"; exit 2; fi;	\
	  git checkout-index -a -f --prefix=/tmp/gitslave-$$VERSION/;								\
	  cd /tmp/gitslave-$$VERSION;												\
	  sed -i "s/{UNTAGGED}/$${VERSION}/" gits;										\
	  sed "s/{UNTAGGED}/$${VERSION}/" contrib/gitslave.spec.in > contrib/gitslave.spec;					\
	  cd ..;														\
	  tar czf gitslave-$$VERSION.tar.gz gitslave-$$VERSION;									\
	  rm -rf /tmp/gitslave-$$VERSION;											\
	  echo /tmp/gitslave-$$VERSION.tar.gz
	@echo "Did you update ReleaseNotes?"

contribtargets:
	$(MAKE) -C contrib

webtargets:
	$(MAKE) -C web

clean nuke:
	rm -rf $(JUNK) *~ core* \#*
	$(MAKE) -C contrib $@
	$(MAKE) -C web $@

check test: clean
	./prep_gitscheck

.PHONY: contribtargets webtargets
