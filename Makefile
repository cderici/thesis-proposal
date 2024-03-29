all: clean
	pdflatex -shell-escape proposal.tex
	bibtex proposal
	pdflatex -shell-escape proposal.tex
	bibtex proposal
	pdflatex -shell-escape proposal.tex

talk:
	$(MAKE) -C defense run

talk-wide:
	$(MAKE) -C defense run-wide

remove-pdf:
	$(RM) proposal.pdf

clean: remove-pdf
	$(RM) *.log *.aux *~ \
	*-blx.bib *.run.xml \
	*.cfg *.glo *.idx *.toc \
	*.ilg *.ind *.out *.lof \
	*.lot *.bbl *.blg *.gls *.cut *.hd \
	*.dvi *.ps *.thm *.tgz *.zip *.rpi
