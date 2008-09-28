

all:
	@echo Done.

install:
	install gits /usr/local/bin

clean:
	rm -rf checkdir *~ core* \#*
