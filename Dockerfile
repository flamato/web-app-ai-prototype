ARG UBUNTU_VERSION=18.04

FROM ubuntu:${UBUNTU_VERSION}

ARG _PY_SUFFIX=3
ARG PYTHON=python${_PY_SUFFIX}
ARG PIP=pip${_PY_SUFFIX}

# Needed for string substitution
SHELL ["/bin/bash", "-c"]
RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    pkg-config \
    rsync \
    software-properties-common \
    unzip \
    wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# See http://bugs.python.org/issue19846
ENV LANG C.UTF-8

RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends \
    ${PYTHON} \
    ${PYTHON}-dev \
    ${PYTHON}-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN ${PIP} --no-cache-dir install --upgrade \
    pip \
    setuptools

# Some TF tools expect a "python" binary
RUN ln -s $(which ${PYTHON}) /usr/local/bin/python

RUN ${PIP} install flask

ENV WORKDIR=/usr/src/app

WORKDIR ${WORKDIR}

COPY ./hello.py /usr/src/app

#CMD 
