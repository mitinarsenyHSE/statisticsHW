.SECONDEXPANSION:

SOURCE_FILE ?= src/hw.md
BUILD_PATH ?= build
TEMPLATES_PATH ?= templates

PANDOC_OPTIONS =\
	--from=markdown+intraword_underscores \
	--toc \
	--number-sections \
	--filter=pandoc-crossref \
	# --top-level-division=chapter \

PANDOC_HTML_OPTIONS =\
	--standalone \
	--section-divs \
	--katex

PANDOC_TEX_OPTIONS =\
	--template=$(TEMPLATES_PATH)/template.tex

PANDOC_PDF_OPTIONS = $(PANDOC_TEX_OPTIONS) \
	# --pdf-engine=xelatex

need_template = $(addsuffix $(firstword $(suffix $1)),$(TEMPLATES_PATH)/template)

.PHONY: all
all: pdf html nojekyll

.PHONY: html
html: $(BUILD_PATH)/index.html
$(BUILD_PATH)/index.html: $(SOURCE_FILE) $$(call need_template,$$@) | $$(@D)/.f
	pandoc $(PANDOC_OPTIONS) $(PANDOC_HTML_OPTIONS) --output=$@ $<

.PHONY: tex
tex: $(BUILD_PATH)/index.tex
$(BUILD_PATH)/index.tex: $(SOURCE_FILE) $$(call need_template,$$@)| $$(@D)/.f
	pandoc $(PANDOC_OPTIONS) $(PANDOC_PDF_OPTIONS) --output=$@ $<

.PHONY: pdf
pdf: $(BUILD_PATH)/index.pdf
$(BUILD_PATH)/index.pdf: $(SOURCE_FILE) | $$(@D)/.f
	pandoc $(PANDOC_OPTIONS) $(PANDOC_PDF_OPTIONS) --output=$@ $<


.PRECIOUS: $(BUILD_PATH)/.f
$(BUILD_PATH)/.f:
	@mkdir -p $(@D)

.PHONY: nojekyll
# Tell GitHub Pages not to use Jekyll
nojekyll: $(BUILD_PATH)/.nojekyll
$(BUILD_PATH)/.nojekyll: | $$(@D)/.f
	touch $@

.PHONY: clean
clean:
	rm -rf $(BUILD_PATH)
