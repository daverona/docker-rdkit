FROM alpine:3.10

ARG RDKIT_VERSION=Release_2020_03_1
ARG RDKIT_HOME=/usr/local/rdkit/$RDKIT_VERSION

# 1. Install packages required in RDKit runtime environment
#    python3-pandas and python3-pil are required by ctest later on
# 2. Update Python pandas version to 0.25 or above
#    Without this update, pandas 0.22.0 is used and Test #167 will fail
#    with "ModuleNotFoundError: No module named 'pandas.io.formats.html'"
RUN apk add --no-cache \
    boost-iostreams \
    boost-python3 \
    boost-regex \
    boost-serialization \
    boost-system \
    eigen \
    py3-cairo \
    py3-numpy \
    py3-pillow \
    python3 \
  && pip3 install --no-cache-dir --upgrade \
    pip \
    setuptools \
    wheel \
  && apk add --no-cache --virtual=build-deps \
    g++ \
    gfortran \
  && ln -s /usr/include/locale.h /usr/include/xlocale.h \
  && pip3 install --no-cache-dir "pandas>=0.25.0" \
  && rm -rf /root/.cache \
  && rm /usr/include/xlocale.h \
  && apk del --no-cache build-deps

# 1. Install packages required to build RDKit
# 2. Download, decompress RDKit source and run cmake
# 3. Build, install and test RDKit
# 4. Remove packages installed to build RDKit
# @see https://github.com/rdkit/rdkit/blob/master/Docs/Book/Install.md#linux-and-os-x
RUN apk add --no-cache --virtual=build-deps \
    build-base \
    boost-dev \
    cairo-dev \
    cmake \
    eigen-dev \
    python3-dev \
  && wget --quiet --output-document=- https://github.com/rdkit/rdkit/archive/$RDKIT_VERSION.tar.gz | tar -zxvf - -C /tmp \
  && mkdir -p /tmp/rdkit-$RDKIT_VERSION/build \
  && cd /tmp/rdkit-$RDKIT_VERSION/build \
  && cmake .. \
    -Wno-dev \
    -DRDK_BUILD_INCHI_SUPPORT=ON \
    -DRDK_INSTALL_INTREE=OFF \
    -DRDK_BUILD_CAIRO_SUPPORT=ON \
    -DPYTHON_EXECUTABLE=/usr/bin/python3.7 \
    -DPYTHON_INCLUDE_DIR=/usr/include/python3.7 \
#    -DCMAKE_INSTALL_PREFIX=$RDKIT_HOME/ \
    -DCMAKE_BUILD_TYPE=Release \
  && sed -i "s|__isascii|isascii|" /tmp/rdkit-$RDKIT_VERSION/External/INCHI-API/src/INCHI_BASE/src/util.c 
#  && make && make install \
#  && ln -s $RDKIT_HOME/lib/python3.7/site-packages/rdkit /usr/lib/python3.7/site-packages/rdkit \
#  && RDBASE=/tmp/rdkit-$RDKIT_VERSION LD_LIBRARY_PATH=$RDKIT_HOME/lib ctest \
#  && apk del --no-cache build-deps \
#  && cd / && rm -rf /tmp/*

# Set environment variables
#ENV LD_LIBRARY_PATH=$RDKIT_HOME/lib
#ENV RDBASE=$RDKIT_HOME

# Configure working directory
#WORKDIR /var/local

#CMD ["/usr/bin/python3"]
