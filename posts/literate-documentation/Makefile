.PHONY: all
all: mdsh

.PHONY: clean
clean: mdsh-clean


MD_FILES := $(wildcard *.md)
MDSH_STAMPS := $(MD_FILES:.md=.md.mdsh.stamp)

%.md.mdsh.stamp: %.md
	@mdsh --inputs $<
	@touch $@

.PHONY: mdsh
mdsh: $(MDSH_STAMPS)

.PHONY: mdsh-clean
mdsh-clean:
	@for f in $(MD_FILES); do mdsh --inputs $$f --clean; done
	@rm -f *.md.mdsh.stamp