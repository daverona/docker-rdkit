ARG ALPINE_VERSION=3.12
FROM alpine:${ALPINE_VERSION}

ARG RDKIT_VERSION=Release_2020_03_1
ARG RDKIT_RELEASE=0
ARG ALPINE_VERSION
RUN _version=${RDKIT_VERSION#Release_} && _version=${_version//_/.} \
  && _release=r${RDKIT_RELEASE} \
  && wget -qO /etc/apk/keys/daverona.rsa.pub https://github.com/daverona/alpine-rdkit/releases/download/alpine${ALPINE_VERSION}-${_version}-${_release}/daverona.rsa.pub \
  && for apk in rdkit py3-rdkit; do \
       wget -q https://github.com/daverona/alpine-rdkit/releases/download/alpine${ALPINE_VERSION}-${_version}-${_release}/${apk}-${_version}-${_release}.apk; \
     done \
  && apk add --no-cache *.apk \
  && rm -rf *.apk /etc/apk/keys/daverona.rsa.pub

CMD ["python3"]
