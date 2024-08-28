FROM osrf/ros:noetic-desktop-full

ENV CERES_VERSION="1.12.0"
ENV PCL_VERSION="1.8.0"

# Install dependencies
RUN apt update && apt-get install -y \
    cmake git \
    libatlas-base-dev \
    libeigen3-dev \
    libgoogle-glog-dev \
    libsuitesparse-dev \
    python3-catkin-tools \
    ros-${ROS_DISTRO}-cv-bridge \
    ros-${ROS_DISTRO}-image-transport \
    ros-${ROS_DISTRO}-message-filters \
    ros-${ROS_DISTRO}-tf && \
  rm -rf /var/lib/apt/lists/*
# Build and install Ceres
RUN git clone https://ceres-solver.googlesource.com/ceres-solver && \
    cd ceres-solver && \
    git checkout tags/${CERES_VERSION} && \
    mkdir build && cd build && \
    cmake .. && \
    make -j12 install && \
    cd ../.. && \
    rm -rf ./ceres-solver
# # Build and install pcl
# RUN git clone https://github.com/PointCloudLibrary/pcl.git && \
#     cd pcl && \
#     git checkout tags/pcl-${PCL_VERSION} && \
#     mkdir build && cd build && \
#     cmake .. && \
#     make -j8 install && \
#     cd ../.. && \
#     rm -rf ./pcl
