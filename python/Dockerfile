FROM python:3.10.6-slim-buster
COPY requirements.txt /
COPY build-inside.sh /
COPY patch /patch
RUN /build-inside.sh