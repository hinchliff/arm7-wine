This work-in-progress is a docker image that can run wine applications on Armv7hf processors using QEMU.  (Testing so far has only been on x86 hardware).  It uses Wine installation (.deb) files built by our other docker container, [arm7-wine-build](https://github.com/hinchliff/arm7-wine-build). This is aimed at the Raspberry Pi 2.

QEMU can be used to build this image on x86 hardware.

You should really build this image yourself, although it does take a long time to build (approx 8 hours on a Core i7, 7th Gen).   It is also available on Docker Hub: https://hub.docker.com/r/hinchliff/arm7-wine-run/


## Running the Docker image
First, you will need to setup Xauthority on your host machine:
```
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
```

Run Notepad:
```
docker run -it \
    -v $XSOCK:$XSOCK \
    -v $XAUTH:$XAUTH \
    -e XAUTHORITY=$XAUTH \
    -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static \
    hinchliff/arm7-wine-run notepad
```

- If you are running on x86 hardware, you will probably need to add this to your `docker run` statement: `-v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static`
- If you need sound, you will probably need to add this to your `docker run` statement: `--device /dev/snd`
- If you need video, you will probably need to add this to your `docker run` statement:`--device /dev/video0`

## References
- https://resin.io/blog/building-arm-containers-on-any-x86-machine-even-dockerhub/
- http://stackoverflow.com/questions/16296753/can-you-run-gui-apps-in-a-docker-container
- https://blog.jessfraz.com/post/docker-containers-on-the-desktop/

