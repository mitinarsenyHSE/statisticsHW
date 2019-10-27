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
	$(info PANDOC_VERBOSE found)
endif

PANDOC_TEMPLATE_BASENAME = $(TEMPLATES_PATH)/template

PANDOC_BUILD_FORMATS =\
  html \
  tex \
  pdf \

pandoc_html_template = $(PANDOC_TEMPLATE_BASENAME).html
pandoc_tex_template = $(PANDOC_TEMPLATE_BASENAME).tex
pandoc_pdf_template = $(PANDOC_TEMPLATE_BASENAME).tex

pandoc_source_default_options =\
  --from=markdown+intraword_underscores \
  --filter=pandoc-crossref \
  --resource-path=$(SOURCE_PATH):. \
  # --top-level-division=chapter \

pandoc_html_options =\
  --css=$(PANDOC_TEMPLATE_BASENAME).css \
  --section-divs \
  --katex \
  --standalone \
  # --self-contained

pandoc_html = $(pandoc_html_options) \
  --to=html5

pandoc_tex_options =\
  --listings \

pandoc_tex = $(pandoc_tex_options) \
  --to=latex

pandoc_pdf = $(pandoc_tex_options) \
  --pdf-engine=$(PANDOC_PDF_ENGINE) \


.PHONY: all $(PANDOC_BUILD_FORMATS)
all: $(PANDOC_BUILD_FORMATS) nojekyll

$(PANDOC_BUILD_FORMATS): %: $(BUILD_PATH)/index.%

$(addprefix $(BUILD_PATH)/index.,$(PANDOC_BUILD_FORMATS)): $(BUILD_PATH)/index.%: $(SOURCE_FILE) $$(pandoc_%_template) | $$(@D)/.f
	$(PANDOC) $(pandoc_source_default_options) $(pandoc_$(patsubst .%,%,$(suffix $@))) \
	  --template=$(word 2,$^) \
	  --output=$@ \
	  $<

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
