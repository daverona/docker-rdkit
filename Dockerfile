FROM alpine:3.10

ARG RDKIT_VERSION=Release_2019_09_2
ARG RDKIT_HOME=/usr/local/rdkit/${RDKIT_VERSION}

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
#    dpkg \
    py3-cairo \
    py3-pillow \
    python3 \
    python3-dev \
#  && update-alternatives --install /usr/bin/python python /usr/bin/python3 10 \
#  && update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10 \
  && pip3 install --no-cache-dir --upgrade pip setuptools wheel \
  && apk add --no-cache --virtual=build-deps g++ gfortran \
  && ln -s /usr/include/locale.h /usr/include/xlocale.h \
  && pip3 install --no-cache-dir "pandas>=0.25.0" \
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
  && cd /tmp \
  && wget --quiet --output-document=- https://github.com/rdkit/rdkit/archive/${RDKIT_VERSION}.tar.gz | tar -zxvf - \
  && mkdir -p /tmp/rdkit-${RDKIT_VERSION}/build \
  && cd /tmp/rdkit-${RDKIT_VERSION}/build \
  && cmake \
    -Wno-dev \
    -DRDK_BUILD_INCHI_SUPPORT=OFF \
    -DRDK_INSTALL_INTREE=OFF \
    -DRDK_BUILD_CAIRO_SUPPORT=ON \
    -DPYTHON_INCLUDE_DIR=/usr/include/python3.7m/ \
    -DPYTHON_EXECUTABLE=/usr/bin/python3.7m \
    -DCMAKE_INSTALL_PREFIX=${RDKIT_HOME}/ \
    -DCMAKE_BUILD_TYPE=Release \
    .. \
  && make && make install \
  && ln -s ${RDKIT_HOME}/lib/python3.7/site-packages/rdkit /usr/lib/python3.7/site-packages/rdkit \
  && RDBASE=/tmp/rdkit-${RDKIT_VERSION} LD_LIBRARY_PATH=${RDKIT_HOME}/lib ctest \
  && apk del build-deps \
  && cd / && rm -rf /tmp/*

#RUN cd /tmp/rdkit-${RDKIT_VERSION}/build \
#  && RDBASE=/tmp/rdkit-${RDKIT_VERSION} LD_LIBRARY_PATH=${RDKIT_HOME}/lib ctest \
#  && apk del build-deps \
#  && cd / && rm -rf /tmp/*

# Set up bash environment variables
ENV LD_LIBRARY_PATH=${RDKIT_HOME}/lib
ENV RDBASE=${RDKIT_HOME}

# Configure working directory
WORKDIR /var/local

CMD ["/usr/bin/python3"]

#    glib \
#    glib-dev \

#ENV LANG=C.UTF-8

# Here we install GNU libc (aka glibc) and set C.UTF-8 locale as default.
#RUN ALPINE_GLIBC_BASE_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download" \
#  && ALPINE_GLIBC_PACKAGE_VERSION="2.30-r0" \
#  && ALPINE_GLIBC_BASE_PACKAGE_FILENAME="glibc-$ALPINE_GLIBC_PACKAGE_VERSION.apk" \
#  && ALPINE_GLIBC_BIN_PACKAGE_FILENAME="glibc-bin-$ALPINE_GLIBC_PACKAGE_VERSION.apk" \
#  && ALPINE_GLIBC_I18N_PACKAGE_FILENAME="glibc-i18n-$ALPINE_GLIBC_PACKAGE_VERSION.apk" \
#  && apk add --no-cache --virtual=.build-deps ca-certificates \
#  && echo -e "\
#-----BEGIN PUBLIC KEY-----\n\
#MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApZ2u1KJKUu/fW4A25y9m\n\
#y70AGEa/J3Wi5ibNVGNn1gT1r0VfgeWd0pUybS4UmcHdiNzxJPgoWQhV2SSW1JYu\n\
#tOqKZF5QSN6X937PTUpNBjUvLtTQ1ve1fp39uf/lEXPpFpOPL88LKnDBgbh7wkCp\n\
#m2KzLVGChf83MS0ShL6G9EQIAUxLm99VpgRjwqTQ/KfzGtpke1wqws4au0Ab4qPY\n\
#KXvMLSPLUp7cfulWvhmZSegr5AdhNw5KNizPqCJT8ZrGvgHypXyiFvvAH5YRtSsc\n\
#Zvo9GI2e2MaZyo9/lvb+LbLEJZKEQckqRj4P26gmASrZEPStwc+yqy1ShHLA0j6m\n\
#1QIDAQAB\n\
#-----END PUBLIC KEY-----" > /etc/apk/keys/sgerrand.rsa.pub \
#  && wget --quiet \
#    "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
#    "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
#    "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" \
#  && apk add --no-cache \
#    "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
#    "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
#    "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" \
#  && rm /etc/apk/keys/sgerrand.rsa.pub \
#  && /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 "$LANG" || true \
#  && echo "export LANG=$LANG" > /etc/profile.d/locale.sh \
#  && apk del glibc-i18n \
#  && apk del .build-deps \
#  && rm -rf \
#    "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
#    "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
#    "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME"

