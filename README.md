# daverona/rdkit

[![pipeline status](https://gitlab.com/daverona/docker/rdkit/badges/master/pipeline.svg)](https://gitlab.com/daverona/docker/rdkit/commits/master)

This is a repository for Docker images of RDKit (Open-Source Cheminformatics Software) library.

* GitLab source repository: [https://gitlab.com/daverona/docker/rdkit](https://gitlab.com/daverona/docker/rdkit)
* Docker Hub repository: [https://hub.docker.com/r/daverona/rdkit](https://hub.docker.com/r/daverona/rdkit)

Available versions are:

* [Release\_2020\_03\_2-ubuntu18.04](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2020_03_2-ubuntu18.04/Dockerfile), [Release\_2020\_03\_2](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2020_03_2/Dockerfile), [latest](https://gitlab.com/daverona/docker/rdkit/-/blob/latest/Dockerfile)
* [Release\_2020\_03\_1-alpine3.10](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2020_03_1-alpine3.10/Dockerfile), [Release\_2020\_03\_1](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2020_03_1/Dockerfile)
* [Release\_2020\_03\_1-ubuntu18.04](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2020_03_1-ubuntu18.04/Dockerfile)
* [Release\_2019\_09\_3-alpine3.10](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2019_09_3-alpine3.10/Dockerfile), [Release\_2019\_09\_3](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2019_09_3/Dockerfile)
* [Release\_2019\_09\_3-ubuntu18.04](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2019_09_3-ubuntu18.04/Dockerfile)
* [Release\_2019\_09\_2-alpine3.10](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2019_09_2-alpine3.10/Dockerfile), [Release\_2019\_09\_2](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2019_09_2/Dockerfile)
* [Release\_2019\_09\_2-ubuntu18.04](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2019_09_2-ubuntu18.04/Dockerfile)
* [Release\_2019\_09\_1-ubuntu18.04](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2019_09_1-ubuntu18.04/Dockerfile)
* [Release\_2019\_03\_4-ubuntu18.04](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2019_03_4-ubuntu18.04/Dockerfile)

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

## References

* [https://github.com/rdkit/rdkit](https://github.com/rdkit/rdkit)
* [https://github.com/rdkit/rdkit/blob/master/Docs/Book/Install.md](https://github.com/rdkit/rdkit/blob/master/Docs/Book/Install.md)
