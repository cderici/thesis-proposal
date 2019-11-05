all:
	pdflatex proposal.tex 
	bibtex proposal
	pdflatex proposal.tex 
	bibtex proposal
	pdflatex proposal.tex

remove-pdf:
	$(RM) proposal.pdf

clean: remove-pdf
	$(RM) *.log *.aux *~ \
	*-blx.bib *.run.xml \
	*.cfg *.glo *.idx *.toc \
	*.ilg *.ind *.out *.lof \
	*.lot *.bbl *.blg *.gls *.cut *.hd \
	*.dvi *.ps *.thm *.tgz *.zip *.rpi
