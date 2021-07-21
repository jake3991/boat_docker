# you will find the usb device in the /sys/bus/usb folder
# sidescan usb config
sudo bash -c "echo -n 1-3.1:1.0 >/sys/bus/usb/drivers/ftdi_sio/unbind"
sudo bash -c "echo -n 1-3.1:1.1 >/sys/bus/usb/drivers/ftdi_sio/unbind"

# give permissions to the usb socket
sudo chown root:boat /dev/bus/usb/001/*

# start the docker image
sudo docker run --rm -it --net=host --ipc=host --pid=host -v /media/boat/external_dr:/media/root/external_dr -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY="$DISPLAY" --privileged -v /dev:/dev -v /dev/bus/usb:/dev/bus/usb wrc/boat:humble bash


