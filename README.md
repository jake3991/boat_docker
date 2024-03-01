# boat_docker

sudo make boat-humble

sudo docker run --rm -it --net=host --ipc=host --pid=host -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY="$DISPLAY" --privileged -v /dev/bus/usb:/dev/bus/usb wrc/boat:humble bash


sudo docker run -ti --net host -v /dev/shm:/dev/shm wrc/boat:humble bash