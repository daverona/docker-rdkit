# daverona/rdkit

[`ubuntu`](https://gitlab.com/daverona/docker/rdkit)
[![pipeline status](https://gitlab.com/daverona/docker/rdkit/badges/master/pipeline.svg)](https://gitlab.com/daverona/docker/rdkit/commits/master)

[`alpine`](https://gitlab.com/daverona/docker/rdkit/-/tree/alpine)
[![pipeline status](https://gitlab.com/daverona/docker/rdkit/badges/alpine/pipeline.svg)](https://gitlab.com/daverona/docker/rdkit/commits/alpine)

This is a repository for Docker images of [RDKit](https://github.com/rdkit/rdkit) (Open-Source Cheminformatics Software) library.

* GitLab source repository: [https://gitlab.com/daverona/docker/rdkit](https://gitlab.com/daverona/docker/rdkit/-/tree/alpine)
* Docker Hub repository: [https://hub.docker.com/r/daverona/rdkit](https://hub.docker.com/r/daverona/rdkit)

Available versions are:

| Version | Ubuntu | Alpine |
|---|---|---|
| Release\_2020\_03\_3 | [Release\_2020\_03\_3](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2020_03_3/Dockerfile), [latest](https://gitlab.com/daverona/docker/rdkit/-/blob/latest/Dockerfile) | [Release\_2020\_03\_3-alpine3.10](https://gitlab.com/daverona/docker/rdkit/-/blob/Release_2020_03_3-alpine3.10/Dockerfile) |
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

## References

* [https://github.com/rdkit/rdkit](https://github.com/rdkit/rdkit)
* [https://github.com/rdkit/rdkit/blob/master/Docs/Book/Install.md](https://github.com/rdkit/rdkit/blob/master/Docs/Book/Install.md)
