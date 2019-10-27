<p align="center">
  <a href="https://github.com/mitinarsenyhse/statisticsHW">
    <img src="assets/hseLogo.png" alt="HSE logo" width="20%" />
  </a>
  <h1 align="center">Statistics</h1>
  <p align="center">
    <a href="https://github.com/mitinarsenyHSE/statisticsHW/actions">
      <img align="left" alt="Github Actions" src="https://github.com/mitinarsenyHSE/statisticsHW/workflows/.github/workflows/pandoc.yml/badge.svg">
    </a>
      Homework
    <a href="https://nbviewer.jupyter.org/github/mitinarsenyHSE/statisticsHW/blob/master/src/hw.ipynb">
      <img align="right" alt="nbviewer" src="https://img.shields.io/badge/render-nbviewer-F37726.svg?logo=jupyter&style=flat-square">
    </a>
  </p>
</p>

## PDF

Here is PDF document: [index.pdf](build/index.pdf).

## Dependencies

* [Docker](https://www.docker.com)

## Jupyter

In order to launch Jypyter server for viewing and editing notebooks run:

```bash
docker-compose up --build
```

Then navigate to `http://localhost:8888?token=<token_from_logs>` in your browser.

## Build

To build all:

```bash
docker run --rm -v "${PWD}:/data" --entrypoint="make" mitinarseny/panmake:2.7.3
```

PDF only:

```bash
docker run --rm -v "${PWD}:/data" --entrypoint="make" mitinarseny/panmake:2.7.3 pdf
```

File `build/index.pdf` will be created after command succeed.
