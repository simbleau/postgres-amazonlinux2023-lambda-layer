FROM amazonlinux:2023

ARG postgresql_version
ARG zipfile

# Install necessary dependencies for building PostgreSQL
RUN \
  yum update -y && \
  yum install -y \
    gcc \
    libicu \
    libicu-devel \
    make \
    readline-devel \
    zlib-devel \
    openssl-devel \
    wget \
    tar \
    zip \
    bzip2 \
    shadow-utils

RUN gcc --version && \
    ld --version && \
    ldd --version

RUN \
  useradd builder
USER builder
WORKDIR /home/builder
ENV PREFIX /home/builder/local

# Download and extract PostgreSQL source code
RUN \
  curl -fsSL https://ftp.postgresql.org/pub/source/v${postgresql_version}/postgresql-${postgresql_version}.tar.bz2 \
    -o postgresql-${postgresql_version}.tar.bz2

RUN \
  mkdir ${PREFIX} && \
  tar jxf postgresql-${postgresql_version}.tar.bz2 && \
  cd postgresql-${postgresql_version} && \
  ./configure  \
    --prefix=${PREFIX} \
    --with-openssl \
  && \
  make install

# Package the necessary libraries into a zip file
RUN \
  cd ${PREFIX} && \
  zip --must-match -r ${zipfile} lib/libpq.so.5 /lib64/libssl* && \
  mv ${zipfile} ~

