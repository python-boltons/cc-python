FROM bbugyi/python:2021.09.22

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

### install dpkgs
COPY dpkg-dependencies.txt /tmp/
# hadolint ignore=SC2046
RUN apt-get install -y --no-install-recommends --allow-unauthenticated $(grep "^[A-Za-z]" /tmp/dpkg-dependencies.txt | perl -nE 'print s/^([^#]+)[ ]+#.*/\1/gr') && \
    apt-get clean

USER bryan
