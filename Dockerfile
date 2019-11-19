FROM ubuntu:18.04

ARG RDKIT_VERSION=Release_2019_09_1
ARG RDKIT_HOME=/usr/local/rdkit/${RDKIT_VERSION}
ARG DEBIAN_FRONTEND=noninteractive

# Install packages required in RDKit runtime environment
# python3-pandas and python3-pil are required by ctest later on
RUN apt-get update \
  && apt-get install --yes --quiet --no-install-recommends \
    libboost-iostreams1.65.1 \
    libboost-python1.65.1 \
    libboost-regex1.65.1 \
    libboost-serialization1.65.1 \
    libboost-system1.65.1 \
    python3-cairo \
    python3-pandas \
    python3-pil \
    python3.6 \
    python3.6-dev \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Update Python pandas version to 0.25 or above
# Without this update, pandas version is 0.22.0 and it will fail with Test #167
# with "ModuleNotFoundError: No module named 'pandas.io.formats.html'"
RUN apt-get update \
  && apt-get install --yes --quiet --no-install-recommends \
    python3-pip \
  && apt-get clean && rm -rf /var/lib/apt/lists/* \
  && pip3 install --no-cache-dir --upgrade "pandas>=0.25.0"

# 1. Install packages required to build RDKit
# 2. Download, decompress RDKit source and run cmake
# 3. Build, install and test RDKit
# 4. Remove packages installed to build RDKit
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
    wget" \
  && apt-get update \
  && apt-get install --yes --quiet $build_deps \
  && apt-get clean && rm -rf /var/lib/apt/lists/* \
  && wget --quiet https://github.com/rdkit/rdkit/archive/${RDKIT_VERSION}.tar.gz \
  && rm -rf ~/.wget-hsts \
  && tar -zxvf ${RDKIT_VERSION}.tar.gz \
  && mv rdkit-${RDKIT_VERSION} rdkit \
  && rm -rf ${RDKIT_VERSION}.tar.gz \
  && mkdir -p /rdkit/build \
  && cd /rdkit/build \
  && cmake \
    -Wno-dev \
    -DRDK_BUILD_INCHI_SUPPORT=ON \
    -DRDK_INSTALL_INTREE=OFF \
    -DRDK_BUILD_CAIRO_SUPPORT=ON \
    -DPYTHON_INCLUDE_DIR=/usr/include/python3.6/ \
    -DPYTHON_EXECUTABLE=/usr/bin/python3.6 \
    -DCMAKE_INSTALL_PREFIX=${RDKIT_HOME}/ \
    -DCMAKE_BUILD_TYPE=Release \
    .. \
  && make && make install \
  && ln -s ${RDKIT_HOME}/lib/python3.6/site-packages/rdkit \
    /usr/local/lib/python3.6/dist-packages/rdkit \
  && echo 'export LD_LIBRARY_PATH="'${RDKIT_HOME}'/lib:${LD_LIBRARY_PATH}"' \
    > /etc/profile.d/rdkit.sh \
  && RDBASE=/rdkit LD_LIBRARY_PATH=${RDKIT_HOME}/lib ctest \
  && cd / && rm -rf /rdkit \
  && apt-get purge --yes --auto-remove $build_deps

# Configure entrypoint and working directory
COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
WORKDIR /var/local

ENV RDBASE=${RDKIT_HOME}
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/bin/python3"]
