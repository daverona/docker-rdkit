# daverona/rdkit

* GitLab source repository: [https://gitlab.com/toscana/docker/rdkit](https://gitlab.com/toscana/docker/rdkit)
* Docker Hub repository: [https://hub.docker.com/r/daverona/rdkit](https://hub.docker.com/r/daverona/rdkit)

This is a Docker image of RDKit. This image provides:

* [RDKit](https://github.com/rdkit/rdkit) Release_2019_03_4
* [Python](https://www.python.org/) 3.6

You can use this image as *running environment* for RDKit
as well as *building environment* for RDKit.

## Installation

Install [Docker](https://hub.docker.com/search/?type=edition&offering=community)
if you don't have one. Then pull the image from Docker Hub repository:

```bash
docker image pull daverona/rdkit:Release_2019_03_4-ubuntu18.04
```

or build the image:

```bash
docker image build \
  --tag daverona/rdkit:Release_2019_03_4-ubuntu18.04 \
  .
```

## Quick Start

Run the container:

```bash
docker container run --rm \
  daverona/rdkit:Release_2019_03_4-ubuntu18.04 \
  python3 -c "import RDkit;print(RDKit.__version__)"
```

It will show the version of RDKit in the container.

## Usage

### Using Running Environment

```bash
docker container run --rm \
  --interactive --tty \
  --volume /host/path/to/your/src:/var/local \
  davarona/rdkit:Release_2019_03_4-ubuntu18.04 \
  python3
```

### Installing on Local Ubuntu

#### Copying from Docker Image

```bash
docker container run --rm \
  --volume $PWD:/data \
  daverona/rdkit:Release_2019_03_4-ubuntu18.04 \
  cp -R /usr/local/rdkit/Release_2019_03_4 /data/rdkit
```

### Installing on Local Ubuntu

```
export RDBASE=/path/to/your/rdkit

sudo cp -R rdkit ${RDBASE}
```

* libboost-iostreams1.65.1
* libboost-python1.65.1
* libboost-regex1.65.1
* libboost-serialization1.65.1
* libboost-system1.65.1
* python3-cairo (version 1.16.2-1 or above)
* python3-pandas (version 0.22.0-4 or above)
* python3-pil (version 5.1.0-1 or above)
* python3.6
* python3.6-dev

```
sudo ln -s ${RDBASE}/lib/python3.6/site-packages/rdkit \
  /usr/local/lib/python3.6/dist-packages/rdkit
```

```sh
sudo bash -c 'echo "export LD_LIBRARY_PATH" > /etc/profile.d/rdkit.sh'
```

```sh
echo 'export LD_LIBRARY_PATH="'${RDBASE}'/lib:${LD_LIBRARY_PATH}"' \
  > /etc/profile.d/rdkit.sh
```

### Testing on Local Ubuntu
