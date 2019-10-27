.SECONDEXPANSION:

PANDOC_VERBOSE ?= 0

SOURCE_PATH ?= src
SOURCE_FILE ?= src/hw.md
BUILD_PATH ?= build
TEMPLATES_PATH ?= templates

PANDOC_PDF_ENGINE ?= lualatex

PANDOC = pandoc \
  # --fail-if-warnings \

ifeq ($(PANDOC_VERBOSE), 1)
	PANDOC +=\
	  --verbose
endif

PANDOC_SOURCE_DEFAULT_OPTIONS =\
  --from=markdown+intraword_underscores \
  --filter=pandoc-crossref \
  --resource-path=$(SOURCE_PATH):. \
  # --top-level-division=chapter \

PANDOC_HTML_OPTIONS =\
  --css=$(TEMPLATES_PATH)/template.css \
  --section-divs \
  --katex \
  --standalone \
  # --self-contained

PANDOC_TEX_OPTIONS =\
  --listings \


.PHONY: all
all: html tex pdf nojekyll

.PHONY: html
html: PANDOC_TEMPLATE = $(TEMPLATES_PATH)/template.html
html: PANDOC_OPTIONS = $(PANDOC_HTML_OPTIONS) \
  --to=html5 \
  --template=$(PANDOC_TEMPLATE)
html: $(BUILD_PATH)/index.html

.PHONY: tex
tex: PANDOC_TEMPLATE = $(TEMPLATES_PATH)/template.tex
tex: PANDOC_OPTIONS = $(PANDOC_TEX_OPTIONS) \
  --to=latex \
  --template=$(PANDOC_TEMPLATE)
tex: $(BUILD_PATH)/index.tex

.PHONY: pdf
pdf: PANDOC_TEMPLATE = $(TEMPLATES_PATH)/template.tex
pdf: PANDOC_OPTIONS = $(PANDOC_TEX_OPTIONS) \
  --template=$(PANDOC_TEMPLATE) \
  --pdf-engine=$(PANDOC_PDF_ENGINE)

pdf: $(BUILD_PATH)/index.pdf

$(BUILD_PATH)/%: $(SOURCE_FILE) $$(PANDOC_TEMPLATE) | $$(@D)/.f
	$(PANDOC) $(PANDOC_SOURCE_DEFAULT_OPTIONS) $(PANDOC_OPTIONS) --output=$@ $<

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
