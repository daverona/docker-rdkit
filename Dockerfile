FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

# Install rdkit dependencies
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
  # Note that pandas needs to be updated to 0.25 or higher. Without it, Test #167
  # will fail with "ModuleNotFoundError: No module named 'pandas.io.formats.html'"
  && pip install --no-cache-dir "pandas>=0.25.0"

ARG RDKIT_VERSION=Release_2020_03_1
ARG RDKIT_HOME=/usr/local/rdkit/$RDKIT_VERSION

# Install rdkit
# @see https://github.com/rdkit/rdkit/blob/master/Docs/Book/Install.md#linux-and-os-x
RUN build_deps="\
    build-essential \
    cmake \
    libboost-iostreams1.65-dev \
    libboost-python1.65-dev \
    libboost-regex1.65-dev \
    libboost-serialization1.65-dev \
    libboost-system1.65-dev \
    libboost1.65-dev \
    libcairo2-dev \
    libeigen3-dev \
    python3.6-dev \
    wget" \
  && apt-get update \
  && apt-get install --yes --quiet $build_deps \
  && wget --quiet --no-hsts --output-document=- https://github.com/rdkit/rdkit/archive/$RDKIT_VERSION.tar.gz | tar -zxvf - -C /tmp \
  && mkdir -p /tmp/rdkit-$RDKIT_VERSION/build \
  && cd /tmp/rdkit-$RDKIT_VERSION/build \
  && cmake .. \
    -Wno-dev \
    -DRDK_INSTALL_INTREE=OFF \
    -DRDK_BUILD_CAIRO_SUPPORT=ON \
    -DRDK_BUILD_INCHI_SUPPORT=ON \
    -DPYTHON_EXECUTABLE=/usr/bin/python3.6 \
    -DPYTHON_INCLUDE_DIR=/usr/include/python3.6 \
    -DCMAKE_INSTALL_PREFIX=$RDKIT_HOME \
    -DCMAKE_BUILD_TYPE=Release \
  && make -j $(nproc) && make install \
  && ln -s $RDKIT_HOME/lib/python3.6/site-packages/rdkit /usr/local/lib/python3.6/dist-packages/rdkit \
  && RDBASE=/tmp/rdkit-$RDKIT_VERSION LD_LIBRARY_PATH=$RDKIT_HOME/lib ctest \
  && cd / && rm -rf /tmp/* \
  && apt-get purge --yes --auto-remove $build_deps \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV LD_LIBRARY_PATH=$RDKIT_HOME/lib:$LD_LIBRARY_PATH

WORKDIR /var/local

CMD ["/usr/bin/python3"]
