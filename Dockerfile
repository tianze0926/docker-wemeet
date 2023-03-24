FROM ubuntu:jammy
WORKDIR /app
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update &&\
    apt-get install -y curl libqt5gui5 \
        libnss3 desktop-file-utils libpulse0 libasound2

ARG WEMEET_URL
RUN curl -SL $WEMEET_URL -o wemeet.deb &&\
    dpkg -i wemeet.deb &&\
    rm wemeet.deb

RUN useradd -m -U abc

COPY init.sh .
CMD ["/bin/sh", "/app/init.sh"]