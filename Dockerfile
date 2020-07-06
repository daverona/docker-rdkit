FROM alpine:3.12

# Install rdkit dependencies
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
    py3-pip \
    python3 \
  && apk add --no-cache --virtual=build-deps \
    g++ \
    gfortran \
    python3-dev \
  && ln -s /usr/include/locale.h /usr/include/xlocale.h \
  && python3 -m pip install --no-cache-dir --upgrade pip \
  # Note that pandas needs to be updated to 0.25 or higher. Without it, Test #167 
  # will fail with "ModuleNotFoundError: No module named 'pandas.io.formats.html'"
  && pip3 install --no-cache-dir "pandas>=0.25.0" \
  && rm -rf /root/.cache \
  && rm /usr/include/xlocale.h \
  && apk del --no-cache build-deps

ARG RDKIT_VERSION=Release_2020_03_4
ARG RDKIT_HOME=/usr/local/rdkit/$RDKIT_VERSION

# Install rdkit dependencies
# @see https://github.com/rdkit/rdkit/blob/master/Docs/Book/Install.md#linux-and-os-x
RUN apk add --no-cache --virtual=build-deps \
    boost-dev \
    build-base \
    cairo-dev \
    cmake \
    eigen-dev \
    py3-numpy-dev \
    python3-dev \
  && wget --quiet --output-document=- https://github.com/rdkit/rdkit/archive/$RDKIT_VERSION.tar.gz | tar -zxvf - -C /tmp \
  && mkdir -p /tmp/rdkit-$RDKIT_VERSION/build \
  && cd /tmp/rdkit-$RDKIT_VERSION/build \
  # This is a patch for Boost 1.72.0. Not required for 1.56.0.
  && sed -i -e "255s|QUIET|system iostreams QUIET|" -e "263s|REQUIRED|system iostreams REQUIRED|" ../CMakeLists.txt \
  && cmake .. \
    -DCMAKE_INSTALL_PREFIX=$RDKIT_HOME \
    -DCMAKE_BUILD_TYPE=Release \
    -DPYTHON_EXECUTABLE="$(which python3)" \
    -DPYTHON_INCLUDE_DIR="$(python3 -c 'from sysconfig import get_paths; print(get_paths()["include"])')" \
    -DRDK_BUILD_CAIRO_SUPPORT=ON \
    -DRDK_BUILD_INCHI_SUPPORT=ON \
    -DRDK_INSTALL_INTREE=OFF \
    -Wno-dev \
  && sed -i "s|__isascii|isascii|" /tmp/rdkit-$RDKIT_VERSION/External/INCHI-API/src/INCHI_BASE/src/util.c \
  && make -j $(nproc) && make install \
  && ln -s $RDKIT_HOME/lib/python3.7/site-packages/rdkit "$(python3 -c 'import site; print(site.getsitepackages()[0])')/rdkit" \
  && RDBASE=/tmp/rdkit-$RDKIT_VERSION LD_LIBRARY_PATH=$RDKIT_HOME/lib ctest \
  && cd / && rm -rf /tmp/* \
  && apk del --no-cache build-deps

# Set environment variables
ENV LD_LIBRARY_PATH=$RDKIT_HOME/lib:$LD_LIBRARY_PATH

WORKDIR /var/local

CMD ["/usr/bin/python3"]
