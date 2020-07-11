# daverona/rdkit <!-- rdkit docker rdkit -->

[`ubuntu`](https://gitlab.com/daverona/docker/rdkit)
[![pipeline status](https://gitlab.com/daverona/docker/rdkit/badges/master/pipeline.svg)](https://gitlab.com/daverona/docker/rdkit/commits/master)

[`alpine`](https://gitlab.com/daverona/docker/rdkit/-/tree/alpine)
[![pipeline status](https://gitlab.com/daverona/docker/rdkit/badges/alpine/pipeline.svg)](https://gitlab.com/daverona/docker/rdkit/commits/alpine)

This is a repository for Docker images of [RDKit](https://github.com/rdkit/rdkit) (Open-Source Cheminformatics Software) library.

* GitLab repository: [https://gitlab.com/daverona/docker/rdkit](https://gitlab.com/daverona/docker/rdkit)
* Docker registry: [https://hub.docker.com/r/daverona/rdkit](https://hub.docker.com/r/daverona/rdkit)
* Available releases: [https://gitlab.com/daverona/docker/rdkit/-/releases](https://gitlab.com/daverona/docker/rdkit/-/releases)

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
# Replace Release_2020_03_4 with the version you want on the next two lines
ARG RDKIT_HOME=/usr/local/rdkit/Release_2020_03_4
COPY --from=daverona/rdkit:Release_2020_03_4 $RDKIT_HOME $RDKIT_HOME
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

* RDKit documentation: [https://www.rdkit.org/docs/Install.html](https://www.rdkit.org/docs/Install.html)
* RDKit repository: [https://github.com/rdkit/rdkit](https://github.com/rdkit/rdkit)
