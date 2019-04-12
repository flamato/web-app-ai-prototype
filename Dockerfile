FROM ubuntu

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-dev \
    python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install flask

WORKDIR /usr/src/app
