FROM alpine:3.10

ARG RDKIT_VERSION=Release_2019_09_1
ARG RDKIT_HOME=/usr/local/rdkit/${RDKIT_VERSION}

# Install packages required in RDKit runtime environment
# py3-pillow is required by ctest later on
RUN apk add --no-cache \
    boost-iostreams \
    boost-python3 \
    boost-regex \
    boost-serialization \
    boost-system \
    dpkg \
    py3-cairo \
    py3-pillow \
    python3 \
    python3-dev \
  && update-alternatives --install /usr/bin/python python /usr/bin/python3 10 \
  && update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10 \
  && pip install --no-cache-dir --upgrade pip setuptools wheel

# Alpine does not have py3-pandas, which is required by ctest later on.
# So we build one.  RDKit Release_Release_2019_09_1 requires
# pandas 0.25 or above. Otherwise, it will fail in Test #167
# with "ModuleNotFoundError: No module named 'pandas.io.formats.html'"
RUN apk add --no-cache --virtual=build-deps g++ gfortran \
  && ln -s /usr/include/locale.h /usr/include/xlocale.h \
  && pip install --no-cache-dir "pandas>=0.25.0" \
  && rm /usr/include/xlocale.h \
  && apk del build-deps

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
  && wget --quiet --no-cache https://github.com/rdkit/rdkit/archive/${RDKIT_VERSION}.tar.gz \
  && tar -zxvf ${RDKIT_VERSION}.tar.gz \
  && mv rdkit-${RDKIT_VERSION} rdkit \
  && rm -rf ${RDKIT_VERSION}.tar.gz \
  && mkdir -p /rdkit/build 

RUN cd /rdkit/build \
  && cmake \
    -Wno-dev \
    -DRDK_BUILD_INCHI_SUPPORT=ON \
    -DRDK_INSTALL_INTREE=OFF \
    -DRDK_BUILD_CAIRO_SUPPORT=ON \
    -DPYTHON_INCLUDE_DIR=/usr/include/python3.7m/ \
    -DPYTHON_EXECUTABLE=/usr/bin/python3.7m \
    -DCMAKE_INSTALL_PREFIX=${RDKIT_HOME}/ \
    -DCMAKE_BUILD_TYPE=Release \
    .. \
  && make && make install 
#  && ln -s ${RDKIT_HOME}/lib/python3.7m/site-packages/rdkit \
#    /usr/local/lib/python3.7m/dist-packages/rdkit \
#  && RDBASE=/rdkit LD_LIBRARY_PATH=${RDKIT_HOME}/lib ctest \
#  && cd / && rm -rf /rdkit \
#  && apk del build-deps

# Set up bash environment variables
# The second echo is needed because "docker exec ... bash" gives a non-login shell.
#RUN echo 'export LD_LIBRARY_PATH="'${RDKIT_HOME}'/lib:${LD_LIBRARY_PATH}"' \
#    > /etc/profile.d/rdkit.sh \
#  && echo "[ -v \"LD_LIBRARY_PATH\" ] || `cat /etc/profile.d/rdkit.sh`" \
#    >> /etc/bash.bashrc

# Configure entrypoint and working directory
#COPY ./docker-entrypoint.sh /
#RUN chmod +x /docker-entrypoint.sh
#WORKDIR /var/local

#ENV RDBASE=${RDKIT_HOME}
#ENTRYPOINT ["/docker-entrypoint.sh"]
#CMD ["/usr/bin/python3"]
