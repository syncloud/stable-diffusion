FROM python:3.8-slim-buster
COPY requirements.txt /
COPY build-inside.sh /
COPY patch /patch
RUN /build-inside.sh