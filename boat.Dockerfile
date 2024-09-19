ARG ROS_DISTRO=humble
FROM ros:${ROS_DISTRO}

ARG DEBIAN_FRONTEND=noninteractive 

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && apt-get install --no-install-recommends -y \
    usbutils \
    nano \
    python3-colcon-common-extensions \
    python3-colcon-clean \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN sudo apt update
RUN sudo apt-get install build-essential
RUN sudo apt update

RUN sudo apt-get install usbutils
RUN sudo apt-get install -y libpcap-dev 
RUN sudo apt install ros-humble-diagnostic-updater
RUN sudo apt-get install -y libpcap-dev 
RUN sudo apt-get install -y ros-humble-angles
RUN sudo apt-get install -y ros-humble-pcl-ros
RUN sudo apt-get install -y ros-humble-cv-bridge
#RUN sudo apt-get install usbutils

# RUN sudo apt install python3-colcon-common-extension
RUN sudo apt install -y python3-pip
RUN pip install pymavlink
RUN pip install pyserial
RUN pip install mavproxy
RUN pip install smbus2
RUN pip install websocket-client

USER 0
RUN mkdir -p /ros_ws/src/
USER $CONTAINER_USER_ID

# copy the startup script
COPY start_in_docker.sh start_in_docker.sh
COPY warm_up.sh warm_up.sh
RUN sudo chmod +x ./start_in_docker.sh
RUN sudo chmod +x ./warm_up.sh

# copy the code
COPY boat_packages/vectornav /ros_ws/src/vectornav
COPY boat_packages/starfish_ros /ros_ws/src/starfish_ros
COPY boat_packages/velodyne /ros_ws/src/velodyne
COPY boat_packages/dvl_a50 /ros_ws/src/dvl_a50
COPY boat_packages/dvl_msgs /ros_ws/src/dvl_msgs
COPY boat_packages/sonar_oculus /ros_ws/src/sonar_oculus

#build
#RUN /ros_entrypoint.sh colcon build --base-paths ros_ws/ --build-base ros_ws/build --install-base ros_ws/install
RUN /ros_entrypoint.sh
#RUN source /opt/ros/humble/setup.bash 
WORKDIR ros_ws/
#RUN colcon build
RUN /bin/bash -c "source /opt/ros/humble/setup.bash; colcon build"
# RUN sed -i "$(wc -l < /ros_entrypoint.sh)i\\source \"//install/setup.bash\"\\" /ros_entrypoint.sh

ENTRYPOINT [ "/ros_entrypoint.sh" ]
