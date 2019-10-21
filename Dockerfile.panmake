ARG PANDOC_VERSION=2.7.3
FROM pandoc/latex:${PANDOC_VERSION}

RUN apk add --no-cache \
  make \
  msttcorefonts-installer fontconfig \
  jq \
  && update-ms-fonts

ARG FONTS_PATH=/root/.local/share/fonts
RUN mkdir -p "${FONTS_PATH}" \
  && for type in Bold Light Medium Regular Retina; do \
      wget "https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true" -O "${FONTS_PATH}/FiraCode-${type}.ttf"; \
    done \
  && fc-cache -f

RUN tlmgr update --self \
  && tlmgr install \
    lstfiracode \
    mnsymbol \
    footnotebackref \
    ctablestack
