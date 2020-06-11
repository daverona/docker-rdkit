# daverona/rdkit <!-- rdkit docker rdkit -->

[`ubuntu`](https://gitlab.com/daverona/docker/rdkit)
[![pipeline status](https://gitlab.com/daverona/docker/rdkit/badges/master/pipeline.svg)](https://gitlab.com/daverona/docker/rdkit/commits/master)

[`alpine`](https://gitlab.com/daverona/docker/rdkit/-/tree/alpine)
[![pipeline status](https://gitlab.com/daverona/docker/rdkit/badges/alpine/pipeline.svg)](https://gitlab.com/daverona/docker/rdkit/commits/alpine)

This is a repository for Docker images of [RDKit](https://github.com/rdkit/rdkit) (Open-Source Cheminformatics Software) library.

* GitLab source repository: [https://gitlab.com/daverona/docker/rdkit](https://gitlab.com/daverona/docker/rdkit)
* Docker Hub repository: [https://hub.docker.com/r/daverona/rdkit](https://hub.docker.com/r/daverona/rdkit)

Available versions are:

| Version | Ubuntu | Alpine |
|---|---|---|
| 2020\_03\_3 | [2020\_03\_3](https://gitlab.com/daverona/docker/rdkit/-/blob/2020_03_3/Dockerfile), [latest](https://gitlab.com/daverona/docker/rdkit/-/blob/2020_03_3/Dockerfile) | [2020\_03\_3-alpine3.10](https://gitlab.com/daverona/docker/rdkit/-/blob/2020_03_3-alpine3.10/Dockerfile) |
| Release\_2020\_03\_2 | [Release\_2020\_03\_2](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2020_03_2/Dockerfile) | [Release\_2020\_03\_2-alpine3.10](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2020_03_2-alpine3.10/Dockerfile) |
| Release\_2020\_03\_1 | [Release\_2020\_03\_1](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2020_03_1/Dockerfile) | [Release\_2020\_03\_1-alpine3.10](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2020_03_1-alpine3.10/Dockerfile) |
| Release\_2019\_09\_3 | [Release\_2019\_09\_3](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2019_09_3/Dockerfile) | [Release\_2019\_09\_3-alpine3.10](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2019_09_3-alpine3.10/Dockerfile) |
| Release\_2019\_09\_2 | [Release\_2019\_09\_2](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2019_09_2/Dockerfile) | [Release\_2019\_09\_2-alpine3.10](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2019_09_2-alpine3.10/Dockerfile) |
| Release\_2019\_09\_1 | [Release\_2019\_09\_1](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2019_09_1/Dockerfile) | [Release\_2019\_09\_1-alpine3.10](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2019_09_1-alpine3.10/Dockerfile) |
| Release\_2019\_03\_4 | [Release\_2019\_03\_4](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2019_03_4/Dockerfile) | [Release\_2019\_03\_4-alpine3.10](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2019_03_4-alpine3.10/Dockerfile) |
| Release\_2019\_03\_3 | [Release\_2019\_03\_2](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2019_03_3/Dockerfile) | [Release\_2019\_03\_3-alpine3.10](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2019_03_3-alpine3.10/Dockerfile) |
| Release\_2019\_03\_2 | [Release\_2019\_03\_2](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2019_03_2/Dockerfile) | [Release\_2019\_03\_2-alpine3.10](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2019_03_2-alpine3.10/Dockerfile) |

## Installation

Pull the image from Docker Hub repository:

```bash
docker image pull daverona/rdkit
```

## Quick Start

Run the container:

```bash
docker container run --rm \
  daverona/rdkit \
  python3 -c "import rdkit;print(rdkit.__version__)"
```

It will show the version of RDKit built in the container.

If you want a Python 3 shell with RDKit available, run the container:

```bash
docker container run --rm \
  --interactive --tty \
  daverona/rdkit
```

## Advanced Usages 

### Copy to Another Docker Image

To copy RDKit from this image to yours *not as* base image, add the following:

```dockerfile
# Replace 2020_03_3 (two occurences) with desired version
ARG RDKIT_HOME=/usr/local/rdkit/2020_03_3
COPY --from=daverona/rdkit:2020_03_3 $RDKIT_HOME $RDKIT_HOME
RUN apt-get update \
  && apt-get install --yes --quiet --no-install-recommends \
    libboost-iostreams1.65.1 \
    libboost-python1.65.1 \
    libboost-regex1.65.1 \
    libboost-serialization1.65.1 \
    libboost-system1.65.1 \
    libpython3.6 \
    python3 \
    python3-cairo \
    python3-numpy \
    python3-pil \
    python3-pip \
  && apt-get clean && rm -rf /var/lib/apt/lists/* \
  && python3 -m pip install --no-cache-dir --upgrade pip \
  && pip install --no-cache-dir "pandas>=0.25.0" \
  && ln -s $RDKIT_HOME/lib/python3.6/site-packages/rdkit /usr/local/lib/python3.6/dist-packages/rdkit
ENV LD_LIBRARY_PATH=$RDKIT_HOME/lib:$LD_LIBRARY_PATH
```

## References

* RDKit source repository: [https://github.com/rdkit/rdkit](https://github.com/rdkit/rdkit)
* RDKit documentation: [https://www.rdkit.org/docs/Install.html](https://www.rdkit.org/docs/Install.html)
