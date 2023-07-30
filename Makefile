.PHONY: clean all polylux

all: compile

compile: main.typ
	typst compile $<

watch:
	typst watch main.typ

clean:
	if [ -f "bips.pdf" ]; then rm "bips.pdf"; fi ;\
	if [ -f "main.pdf" ]; then rm "main.pdf"; fi ;\

polylux:
	git submodule update polylux
