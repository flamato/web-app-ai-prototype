ARG UBUNTU_VERSION

FROM ubuntu:${UBUNTU_VERSION}

ARG PYTHON_VERSION
ARG PYTHON=python${PYTHON_VERSION}
ARG PIP=pip${PYTHON_VERSION}

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

# Install web framework : django or flask
ARG WEB_FRAMEWORK=django
RUN ${PIP} install ${WEB_FRAMEWORK}

ENV WORKDIR=/usr/src/app

WORKDIR ${WORKDIR}

COPY ./hello.py /usr/src/app

#CMD
