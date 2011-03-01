
gits-man-page.html: ../gits
	pod2html $^ > $@
	@rm -f pod2htm*.tmp

install: gits-man-page.html ReleaseNotes.txt index.html tutorial-basic.html tutorial.css
	scp $^ bakaproject,gitslave@web.sourceforge.net:/home/project-web/gitslave/htdocs

clean nuke:
	rm -f gits-man-page.html pod2htm* *.tmp
