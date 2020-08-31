# daverona/rdkit

[`ubuntu`](https://gitlab.com/daverona/docker/rdkit)
[![pipeline status](https://gitlab.com/daverona/docker/rdkit/badges/master/pipeline.svg)](https://gitlab.com/daverona/docker/rdkit/commits/master)

[`alpine`](https://gitlab.com/daverona/docker/rdkit/-/tree/alpine)
[![pipeline status](https://gitlab.com/daverona/docker/rdkit/badges/alpine/pipeline.svg)](https://gitlab.com/daverona/docker/rdkit/commits/alpine)

This is a repository for Docker images of [RDKit](https://github.com/rdkit/rdkit) (Open-Source Cheminformatics Software) library.

* GitLab repository: [https://gitlab.com/daverona/docker/rdkit/-/tree/alpine](https://gitlab.com/daverona/docker/rdkit/-/tree/alpine)
* Docker registry: [https://hub.docker.com/r/daverona/rdkit](https://hub.docker.com/r/daverona/rdkit)
* Available releases: [https://gitlab.com/daverona/docker/rdkit/-/releases](https://gitlab.com/daverona/docker/rdkit/-/releases)

## Quick Start

Run a container:

```bash
docker container run --rm \
  --interactive --tty \
  daverona/rdkit
```

In Python 3 shell check the version:

```python
import rdkit
rdkit.__verions__
```

## References

* RDKit repository: [https://github.com/rdkit/rdkit](https://github.com/rdkit/rdkit)
* RDKit installation: [https://github.com/rdkit/rdkit/blob/master/Docs/Book/Install.md](https://github.com/rdkit/rdkit/blob/master/Docs/Book/Install.md)
