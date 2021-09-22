FROM bbugyi/python:2021.09.22

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

### install dpkgs
COPY dpkg-dependencies.txt /tmp/
RUN apt-get install -y --allow-unauthenticated $(cat /tmp/dpkg-dependencies.txt | grep "^[A-Za-z]" | perl -nE 'print s/^([^#]+)[ ]+#.*/\1/gr') && \
    apt-get clean

USER bryan
