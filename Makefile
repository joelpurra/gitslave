

gits.1: gits
	pod2man < $^ > $@

install: gits gits.1
	install -D -m 444 gits.1 /usr/local/share/man/man1
	install gits /usr/local/bin

clean:
	rm -rf checkdir *~ core* \#*

check test:
	./prep_gitscheck
