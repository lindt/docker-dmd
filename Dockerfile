FROM ubuntu:16.04

MAINTAINER Stefan Rohe <think@hotmail.de>

ENV \
  COMPILER=dmd \
  COMPILER_VERSION=2.080.0

RUN apt-get update && apt-get install -y curl libcurl3 build-essential \
 && curl -fsS -o /tmp/install.sh https://dlang.org/install.sh \
 && bash /tmp/install.sh -p /dlang install "${COMPILER}-${COMPILER_VERSION}" \
 && rm /tmp/install.sh \
 && apt-get auto-remove -y curl build-essential \
 && apt-get install -y gcc \
 && rm -rf /var/cache/apt \
 && rm -rf /dlang/${COMPILER}-*/linux/bin32 \
 && rm -rf /dlang/${COMPILER}-*/linux/lib32 \
 && rm -rf /dlang/${COMPILER}-*/html \
 && rm -rf /dlang/dub-1.0.0/dub.tar.gz

ENV \
  PATH=/dlang/dub:/dlang/${COMPILER}-${COMPILER_VERSION}/linux/bin64:${PATH} \
  LD_LIBRARY_PATH=/dlang/${COMPILER}-${COMPILER_VERSION}/linux/lib64 \
  LIBRARY_PATH=/dlang/${COMPILER}-${COMPILER_VERSION}/linux/lib64 \
  PS1="(${COMPILER}-${COMPILER_VERSION}) \\u@\\h:\\w\$"

RUN cd /tmp \
 && echo 'void main() {import std.stdio; stdout.writeln("it works"); }' > test.d \
 && dmd test.d \
 && ./test && rm test*

WORKDIR /src

ENV GOSU_VERSION 1.9
RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates wget \
 && wget -O /usr/local/bin/gosu \
        "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture)" \
 && wget -O /usr/local/bin/gosu.asc \
        "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture).asc" \
 && export GNUPGHOME="$(mktemp -d)" \
 && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
 && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
 && rm -r "${GNUPGHOME}" /usr/local/bin/gosu.asc \
 && chmod +x /usr/local/bin/gosu \
 && gosu nobody true \
 && apt-get auto-remove -y wget \
 && rm -rf /var/lib/apt/lists/* \
 && chmod 755 -R /dlang

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["${COMPILER}"]
