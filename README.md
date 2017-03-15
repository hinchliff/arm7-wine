This work-in-progress is a docker image that builds the Wine source on an Armv7hf processor running Debian.  This is aimed at the Raspberry Pi 2.

QEMU can be used to build this image on x86 hardware.

You should really build this image yourself, although it does take a long time to build (approx 8 hours on a Core i7, 7th Gen).   It is also available on Docker Hub: https://hub.docker.com/r/hinchliff/arm7-wine-build/

## Comments?
You can leave a comment or ask a question [here](https://github.com/hinchliff/arm7-wine-build/issues/1)!

## Running the Docker image
You may need to add `-v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static` to your `docker run` statement if running this image on x86 hardware.

## References
https://resin.io/blog/building-arm-containers-on-any-x86-machine-even-dockerhub/

