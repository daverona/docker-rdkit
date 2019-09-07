# daverona/rdkit

[![pipeline status](https://gitlab.com/toscana/docker/rdkit/badges/master/pipeline.svg)](https://gitlab.com/toscana/docker/rdkit/commits/master)

* GitLab source repository: [https://gitlab.com/toscana/docker/rdkit](https://gitlab.com/toscana/docker/rdkit)
* Docker Hub repository: [https://hub.docker.com/r/daverona/rdkit](https://hub.docker.com/r/daverona/rdkit)

This is a Docker image of RDKit (Open-Source Cheminformatics Software) library. This image provides:

* [RDKit](https://github.com/rdkit/rdkit) Release_2019_03_4
* [Python](https://www.python.org/) 3.6

You can use this image as *running environment* and/or *building environment* for RDKit.

## Installation

Install [Docker](https://hub.docker.com/search/?type=edition&offering=community)
if you don't have one. Then pull the image from Docker Hub repository:

```bash
docker image pull daverona/rdkit:Release_2019_03_4-ubuntu18.04
```

or build the image:

```bash
docker image build \
  --build-arg RDKIT_VERSION=Release_2019_03_4 \
  --tag daverona/rdkit:Release_2019_03_4-ubuntu18.04 \
  .
```

When you build the image, you can specify RDKit version as shown above.
If you don't specify the value of build argument `RDKIT_VERSION`,
Release_2019_03_4 will be used. If you specify `RDKIT_VERSION`, don't forget
to change the tag name accordingly.

## Quick Start

Run the container:

```bash
docker container run --rm \
  daverona/rdkit:Release_2019_03_4-ubuntu18.04 \
  python3 -c "import rdkit;print(rdkit.__version__)"
```

It will show the version of RDKit built in the container.

If you want a Python 3 shell with RDKit available, run the container:

```bash
docker container run --rm \
  --interactive --tty \
  daverona/rdkit:Release_2019_03_4-ubuntu18.04
```

If you quit Python shell, you will exit the container.

## Usage

### Using as Running Environment

You can run the container with your Python source (not RDKit library source
itself but some source written in Python 3 using RDKit library) mounted to the
container:

```bash
docker container run --rm \
  --interactive --tty \
  --volume /host/path/to/your/src:/var/local \
  davarona/rdkit:Release_2019_03_4-ubuntu18.04 \
  bash
```

In the above example directory /host/path/to/your/src is where your Python
source resides and you must change it properly. The command will give you
a bash shell with your source available in the current directory.
You can use this environment just like your local shell environment.

Note that if your Python source writes files to other than /var/local, say /srv,
in this environment and exit the shell, these files will be lost. If this is the
case, you should mount a directory on your machine to /srv in the container:

```bash
docker container run --rm \
  ...
  --volume /host/path/to/your/src:/var/local \
  --volume /host/path/to/data:/srv \
  ...
```

You will get the files under /host/path/to/data on your machine as your source
generates these files in /srv.

### Using as Building Environment

You can take out RDKit library from the image to install on your local system.
Sure, that's possible but your local system should run Ubuntu 18.04 or above
(or similar Linux such as Debian) with the following packages installed:

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

Once these constraints are met, you can follow the steps described below.

#### Copying from Docker Image

Take out RDKit library from the image to the current directory:

```bash
docker container run --rm \
  --volume $PWD:/data \
  daverona/rdkit:Release_2019_03_4-ubuntu18.04 \
  cp -R /usr/local/rdkit /data/rdkit
```

You have a copy of RDKit library under the current directory on your Ubuntu:

```text
rdkit/
    Release_2019_03_4/
        include/
        lib/
        share/
```

#### Installing on Local Ubuntu

Decide where to put the copy of RDKit library on your Ubuntu. Let's assume
you want it under /usr/local/rdkit/Release_2019_03_4. Copy RDKit library and
define environment variable `RDBASE`:

```bash
sudo cp -R rdkit /usr/local/rdkit
export RDBASE=/usr/local/rdkit/Release_2019_03_4
```

Make RDKit library available to your Python:

```bash
sudo ln -s ${RDBASE}/lib/python3.6/site-packages/rdkit \
  /usr/local/lib/python3.6/dist-packages/rdkit
```

Add RDKit library to system library search path:

```bash
sudo bash -c "echo 'export LD_LIBRARY_PATH=\"${RDBASE}/lib\
:\${LD_LIBRARY_PATH}\"' > /etc/profile.d/rdkit.sh"
```
#### Testing on Local Ubuntu

Run the following to see RDKit version:

```bash
. /etc/profile.d/rdkit.sh
python3 -c "import rdkit;print(rdkit.__version__)"
```

Once you see RDKit version, we are done.

Until your Ubuntu system reboots, you (and users on your system who want to use
RDKit) need to run `. /etc/profile.d/rdkit.sh` on new bash shell to have RDKit
library. Once your system reboots, this hassle will be done.

## References

* [https://github.com/rdkit/rdkit](https://github.com/rdkit/rdkit)
* [https://github.com/rdkit/rdkit/blob/master/Docs/Book/Install.md](https://github.com/rdkit/rdkit/blob/master/Docs/Book/Install.md)
