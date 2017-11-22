#!/bin/bash
#clear
echo "" > body.tex
#get some tex from html through markdown (strips a lot of unneeded stuff)
pandoc SpaceXFinalText.html -t markdown_github-raw_html -o spacex.md
pandoc spacex.md --wrap=none -o body.tex #&& rm spacex.md


echo '\begin{document}' | cat - body.tex > temp && mv temp body.tex
echo "\end{document}" >> body.tex
echo '\include{head.tex}' | cat - body.tex > temp && mv temp body.tex


#remove some stuff we don't want
#deletes comments at end
sed -i '/.*cmnt_ref.*/d' body.tex
sed -ir 's/[-]{3,}//g' body.tex
#replacing the cited sources quickly with latex references.
sed -ir 's/((\([0-9]*\)))/\\cite{scs\1}/g' body.tex
#sed -ir '/\\protect\\hyperlink{[^}]*}{[^}]*}/d' body.tex
