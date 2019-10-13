FROM mitinarseny/jupetri

COPY requirements.txt .

RUN conda install --file requirements.txt --quiet --yes

COPY . .
