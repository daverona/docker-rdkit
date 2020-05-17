# daverona/rdkit

[![pipeline status](https://gitlab.com/daverona/docker/rdkit/badges/master/pipeline.svg)](https://gitlab.com/daverona/docker/rdkit/commits/master)

This is a repository for Docker images of [RDKit](https://github.com/rdkit/rdkit) (Open-Source Cheminformatics Software) library.

* GitLab source repository: [https://gitlab.com/daverona/docker/rdkit](https://gitlab.com/daverona/docker/rdkit)
* Docker Hub repository: [https://hub.docker.com/r/daverona/rdkit](https://hub.docker.com/r/daverona/rdkit)

Available versions are:

| Version | Ubuntu | Alpine |
|---|---|---|
| Release\_2020\_03\_2 | [Release\_2020\_03\_2](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2020_03_2/Dockerfile), [latest](https://gitlab.com/daverona/docker/rdkit/-/blob/latest/Dockerfile) | [Release\_2020\_03\_2-alpine3.10](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2020_03_2-alpine3.10/Dockerfile) |
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

## Copy

To use RDKit built by this image without making the image as your base image, follow the next steps.

Place the following to your `Dockerfile` *before* base image `FROM` command and
set `RDKIT_VERSION` properly:

```dockerfile
# Place the following before FROM command of your base image

ARG RDKIT_VERSION=Release_2020_03_2
FROM daverona/rdkit:$RDKIT_VERSION as rdkit-library
```

Place the following *after* your base image `FROM` command and build:

```dockerfile
# Place the following after FROM command of your base image

ARG RDKIT_VERSION
ARG RDKIT_HOME=/usr/local/bin/rdkit/$RDKIT_VERSION
ENV LD_LIBRARY_PATH=$RDKIT_HOME/lib:$LD_LIBRARY_PATH
COPY --from=rdkit-library:$RDKIT_HOME $RDKIT_HOME
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
```

## References

* RDKit source repository: [https://github.com/rdkit/rdkit](https://github.com/rdkit/rdkit)
* RDKit documentation: [https://github.com/rdkit/rdkit/blob/master/Docs/Book/Install.md](https://github.com/rdkit/rdkit/blob/master/Docs/Book/Install.md)
