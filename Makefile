

gits.1: gits
	pod2man < $^ > $@

install: gits gits.1
	mkdir -p /usr/local/share/man/man1
	install -m 444 gits.1 /usr/local/share/man/man1
	VERSION=`./gits --version`; \
	 sed "s/{UNTAGGED}/$${VERSION}/" gits > /usr/local/bin/gits
	chmod 755 /usr/local/bin/gits

README: gits
	pod2text < gits > README

clean nuke:
	rm -rf gits.1 checkdir *~ core* \#*

check test:
	./prep_gitscheck
