# Statistics homework
## Usage
### Run
```bash
docker run --rm \
  -v "${PWD}":/home/jovyan/work \
  -p 8888:8888 \
  mitinarsenyhse/statistics_hw
```
### Build
```bash
docker build -t mitinarsenyhse/statistics_hw:latest .
```
### Push
```bash
docker push mitinarsenyhse/statistics:latest
```
