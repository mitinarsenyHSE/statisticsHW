all: tex html pdf

tex:
	pandoc hw.md --from markdown+latex_macros -V mainfont=Arial -o hw.tex

html:
	pandoc hw.md --from markdown+latex_macros --katex -s -o hw.html

pdf:
	pandoc hw.md --from markdown+latex_macros --pdf-engine=xelatex -V mainfont=Arial -o hw.pdf


