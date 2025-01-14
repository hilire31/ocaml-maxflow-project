.PHONY: all build format edit demo clean

SOURCES=$(wildcard *.dot)
IMAGES=$(SOURCES:.dot=.svg)

src?=0
dst?=5
graph?=graphtest.txt

all: build

build:
	@echo "\n   🚨  COMPILING  🚨 \n"
	dune build src/ftest.exe
	ls src/*.exe > /dev/null && ln -fs src/*.exe .

format:
	ocp-indent --inplace src/*

edit:
	code . -n

demo: build
	@echo "\n   ⚡  EXECUTING  ⚡\n"
	./ftest.exe graphs/${graph} $(src) $(dst) outfile
	@echo "\n   🥁  RESULT (content of outfile)  🥁\n"
	@dot -Tsvg outfile.dot > mongraphe.svg

clean:
	find -L . -name "*~" -delete
	rm -f *.exe
	rm -f *.dot
	dune clean


step : ${IMAGES}
	rm -f *.dot
	
%.svg: %.dot
	@dot -Tsvg $< > $@

