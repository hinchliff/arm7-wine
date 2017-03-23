#FROM resin/rpi-raspbian:jessie-20170111
FROM resin/armv7hf-debian-qemu

RUN [ "cross-build-start" ]

RUN apt-get update && \
    apt-get install \
        libasound2 \
        libexif12 \
        libgl1-mesa-glx \
        libglu1 \
        libglu1-mesa \
        libgphoto2-6 \
        libgphoto2-port10 \
        liblcms2-2 \
        libldap-2.4-2 \
        libmpg123-0 \
        libopenal1 \
        libpcap0.8 \
        libpulse0 \
        libopencl1 \
        libopencl-1.1-1 \
        ocl-icd-libopencl1 \
        libasound2-plugins && \
    apt-get clean

COPY ./wine-resources/* /

RUN dpkg -i wine-stable_2.4.0~jessie_armhf.deb wine-stable-arm_2.4.0~jessie_armhf.deb winehq-stable_2.4.0~jessie_armhf.deb

ENV DISPLAY :0

RUN [ "cross-build-end" ]

