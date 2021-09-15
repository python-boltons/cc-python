FROM python:3.9-bullseye

COPY dpkg-dependencies.txt /tmp/
RUN /opt/bb/bin/apt-get install -y --force-yes --allow-unauthenticated $(cat /tmp/dpkg-dependencies.txt | grep "^[A-Za-z]" | perl -nE 'print s/^([^#]+)[ ]+#.*/\1/gr') && \
    /opt/bb/bin/apt-get clean
