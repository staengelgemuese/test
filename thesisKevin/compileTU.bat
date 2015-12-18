pdfclose --file=indexTU.pdf
pdflatex indexTU
bibtex indexTU
pdflatex indexTU
pdflatex indexTU
pdfopen --file=indexTU.pdf
