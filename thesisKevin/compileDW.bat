del indexOld.pdf
ren index.pdf indexOld.pdf
pdfclose --file=index.pdf
pdflatex index
bibtex index
pdflatex index
pdflatex index
pdfopen --file=index.pdf
