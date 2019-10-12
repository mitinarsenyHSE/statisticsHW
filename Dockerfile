FROM mitinarseny/jupetri

RUN conda install --yes --freeze-installed \
  numpy \
  scipy
