# boat_docker

sudo make boat-humble

sudo docker run --rm -it --net=host -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY="$DISPLAY" --privileged -v /dev/bus/usb:/dev/bus/usb jake/boat:humble bash
