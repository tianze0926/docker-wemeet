FROM ubuntu:jammy
WORKDIR /app
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update &&\
    apt-get install -y curl libqt5gui5 \
        libnss3 desktop-file-utils libpulse0 libasound2 &&\
    apt-get clean

ARG WEMEET_URL=https://updatecdn.meeting.qq.com/cos/da1c30b1a927cd691e4ee60aba829c88/TencentMeeting_0300000000_3.15.1.403_x86_64_default.publish.deb
RUN curl -SL $WEMEET_URL -o wemeet.deb &&\
    dpkg -i wemeet.deb &&\
    rm wemeet.deb &&\
    apt-get clean

RUN useradd -m -U abc
USER abc
CMD ["/bin/bash", "/opt/wemeet/wemeetapp.sh"]
