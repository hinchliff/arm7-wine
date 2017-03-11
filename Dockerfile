#FROM resin/rpi-raspbian:jessie-20170111
FROM resin/armv7hf-debian-qemu

#ENV QEMU_EXECVE 1

#COPY . /usr/bin

#RUN [ "qemu-arm-static", "/bin/sh", "-c", "ln -s resin-xbuild /usr/bin/cross-build-start; ln -s resin-xbuild /usr/bin/cross-build-end; ln /bin/sh /bin/sh.real" ]

RUN [ "cross-build-start" ]

    #apt-get upgrade && \
RUN apt-get update && \
    apt-get install git build-essential

RUN sudo dpkg --add-architecture i386

RUN apt-get install wget

RUN wget https://dl.winehq.org/wine-builds/Release.key && \
    apt-key add Release.key

#RUN [ "cross-build-end" ]

#COPY wine-builds.sources.list  /etc/apt/sources.list.d/
#RUN apt-get update
#RUN apt-get install --install-recommends winehq-staging

#RUN apt-get install mk-build-deps

# Install all of the development libraries needed to compile Wine
RUN apt-get install flex bison libx11-dev libfreetype6-dev

#RUN apt-get install libxcursor1 libxi6 libxshmfence1 libxxf86vm1 libxrandr2 libxinerama1 libxcomposite1 libglu1-mesa libosmesa6 opencl-headers mesa-opencl-icd libpcap-dev libdbus-1-3 libncurses5 libsane libv4l-0 libgphoto2-6 libgphoto2-port10 liblcms2-2 libpulse0 libgstreamer1.0-0 
RUN apt-get install libxcursor-dev libxi-dev libxshmfence-dev libxxf86vm-dev libxrandr-dev libxinerama-dev libxcomposite-dev libglu1-mesa-dev libosmesa6-dev ocl-icd-opencl-dev libpcap-dev libdbus-1-dev libncurses5-dev libsane-dev libv4l-dev libgphoto2-dev liblcms2-dev libpulse-dev libgstreamer1.0-dev

RUN apt-get install oss4-dev libudev-dev libcapi20-dev libcups2-dev libfontconfig1-dev libgsm1-dev libtiff5-dev libmpg123-dev libopenal-dev libldap2-dev gettext libxrender-dev libgl1-mesa-dev libxml2-dev libxslt1-dev libgnutls28-dev libjpeg-dev

# E: Unable to locate package libhal-dev
#RUN apt-get install libgstreamer1.0-0
#RUN apt-get install gstreamer1.0-plugins-base
RUN apt-get install libgstreamer-plugins-base1.0-dev

# Download latest release version of Wine
RUN mkdir -p wine-source && \
    git clone --branch wine-2.3 git://source.winehq.org/git/wine.git wine-source
    #git clone git://source.winehq.org/git/wine.git wine-source

RUN cd wine-source && \
    ./configure

RUN cd wine-source && \
    make

#CMD [ "/usr/bin/qemu-arm-static", "/bin/sh.real" ]

