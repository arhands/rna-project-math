MAIN     = main
LATEX    = pdflatex
BIBTEX   = bibtex
LATEXMK  = latexmk

.PHONY: pdf watch clean

pdf:
	$(LATEX) $(MAIN)
	$(BIBTEX) $(MAIN)
	$(LATEX) $(MAIN)
	$(LATEX) $(MAIN)

watch:
	$(LATEXMK) -pdf -pvc $(MAIN)

clean:
	rm -f $(MAIN).aux $(MAIN).log $(MAIN).bbl $(MAIN).blg \
	      $(MAIN).out $(MAIN).toc $(MAIN).fls $(MAIN).fdb_latexmk \
	      $(MAIN).synctex.gz
