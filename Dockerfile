#FROM resin/rpi-raspbian:jessie-20170111
FROM resin/armv7hf-debian-qemu

RUN [ "cross-build-start" ]

    #apt-get upgrade && \
RUN apt-get update && \
    apt-get install git build-essential

# Install all of the development libraries needed to compile Wine
# The only one from ./configure that we were unable to find in Arm Debian was libhal-dev
RUN apt-get install \
        flex \
        bison \
        libx11-dev \
        libfreetype6-dev \
        libxcursor-dev \
        libxi-dev \
        libxshmfence-dev \
        libxxf86vm-dev \
        libxrandr-dev \
        libxinerama-dev \
        libxcomposite-dev \
        libglu1-mesa-dev \
        libosmesa6-dev \
        ocl-icd-opencl-dev \
        libpcap-dev \
        libdbus-1-dev \
        libncurses5-dev \
        libsane-dev \
        libv4l-dev \
        libgphoto2-dev \
        liblcms2-dev \
        libpulse-dev \
        libgstreamer1.0-dev \
        oss4-dev \
        libudev-dev \
        libcapi20-dev \
        libcups2-dev \
        libfontconfig1-dev \
        libgsm1-dev \
        libtiff5-dev \
        libmpg123-dev \
        libopenal-dev \
        libldap2-dev \
        gettext \
        libxrender-dev \
        libgl1-mesa-dev \
        libxml2-dev \
        libxslt1-dev \
        libgnutls28-dev \
        libjpeg-dev \
        libgstreamer-plugins-base1.0-dev


# dpkg packaging deps
RUN apt-get install \
        devscripts \
        fakeroot \
        autotools-dev \
        autoconf \
        debhelper \
        docbook-to-man \
        docbook-utils \
        docbook-xsl \
        fontforge \
        gawk \
        libacl1-dev \
        libasound2-dev \
        libesd0 \
        libesd0-dev \
        libgtk-3-dev \
        libice-dev \
        libssl-dev \
        libxt-dev \
        prelink \
        sharutils \
        unixodbc-dev

# Download latest release version of Wine
# And prepare to package it
RUN mkdir -p wine-source && \
    git clone --depth 1 --branch wine-2.3 git://source.winehq.org/git/wine.git wine-source && \
    git clone --depth 1 https://github.com/wine-compholio/wine-packaging.git wine-packaging && \
    #git clone --depth 1 https://github.com/hinchliff/wine-packaging.git wine-packaging && \
    cd /wine-packaging && \
    ./generate.py --ver 2.3 --skip-name --out /wine-source debian-jessie-stable && \
    sed -e '/wine-stable-arm.substvars/ s/"\-m32"/"-marm"/' -i /wine-source/debian/rules

# from `dpkg-buildpackage`
#   -us    Do not sign the source package.
#   -uc    Do not sign the .changes file.
#   -nc    Do  not  clean  the source tree.
#   -F     Specifies a normal full build, binary and source  packages  will be  built
#   -tc    Clean  the  source  tree after the package has been built. [keep the image smaller?]
# The -F is necessary to get dpkg-buildpackage to generate the .dsc file
# dpkg-genchanges: error: cannot read ../wine-stable_2.3.0~jessie.dsc: No such file or directory
RUN cd /wine-source && \
    debuild -us -uc -F -tc

RUN [ "cross-build-end" ]
