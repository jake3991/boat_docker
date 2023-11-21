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

RUN sudo apt-get install usbutils

# RUN sudo apt install python3-colcon-common-extensions

RUN git clone "https://github.com/osu-uwrt/vectornav.git" "catkin_ws/src/vectornav" --branch ros2

# RUN /ros_entrypoint.sh colcon build

# RUN sed -i "$(wc -l < /ros_entrypoint.sh)i\\source \"/ros2_ws/install/setup.bash\"\\" /ros_entrypoint.sh

ENTRYPOINT [ "/ros_entrypoint.sh" ]
