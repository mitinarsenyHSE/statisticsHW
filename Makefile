.SECONDEXPANSION:

PANDOC_VERBOSE ?= 0

SOURCE_FILE ?= src/hw.md
BUILD_PATH ?= build
TEMPLATES_PATH ?= templates

PANDOC = pandoc \
	# --fail-if-warnings \

ifeq ($(PANDOC_VERBOSE), 1)
	PANDOC +=\
	  --verbose
endif

PANDOC_MD_OPTIONS =\
	--from=markdown+intraword_underscores \
	# --filter=pandoc-crossref \
	# --top-level-division=chapter \

PANDOC_TEX_OPTIONS =\
	--listings


PANDOC_TEMPLATE_BASENAME = $(TEMPLATES_PATH)/template

PDF_ENGINE = lualatex

.PHONY: all
all: pdf html nojekyll

.PHONY: html
html: $(BUILD_PATH)/index.html
$(BUILD_PATH)/index.html: $(SOURCE_FILE) $$(addsuffix $$(suffix $$@),$$(PANDOC_TEMPLATE_BASENAME)) | $$(@D)/.f
	$(PANDOC) $(PANDOC_MD_OPTIONS) \
	  --standalone \
	  --template=$(word 2,$^) \
	  --section-divs \
	  --katex \
	  --output=$@ \
	  $<

.PHONY: tex
tex: $(BUILD_PATH)/index.tex
$(BUILD_PATH)/index.tex: $(SOURCE_FILE) $$(addsuffix $$(suffix $$@),$$(PANDOC_TEMPLATE_BASENAME)) | $$(@D)/.f
	$(PANDOC) $(PANDOC_MD_OPTIONS) $(PANDOC_TEX_OPTIONS) \
	  --template=$(word 2,$^) \
	  --output=$@ \
	  $<

.PHONY: pdf
pdf: $(BUILD_PATH)/index.pdf
$(BUILD_PATH)/index.pdf: $(SOURCE_FILE) $$(addsuffix .tex,$$(PANDOC_TEMPLATE_BASENAME)) | $$(@D)/.f
	$(PANDOC) $(PANDOC_MD_OPTIONS) $(PANDOC_TEX_OPTIONS) \
	  --template=$(word 2,$^) \
	  --pdf-engine=$(PDF_ENGINE) \
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
