FROM python:3.9-bullseye

COPY dpkg-dependencies.txt /tmp/
RUN apt-get install -y --force-yes --allow-unauthenticated $(cat /tmp/dpkg-dependencies.txt | grep "^[A-Za-z]" | perl -nE 'print s/^([^#]+)[ ]+#.*/\1/gr') && \
    apt-get clean
