FROM nvidia/cuda:latest
# Installing Colmap: Based on installation instructions located at https://colmap.github.io/install.html
RUN apt-get -y update
RUN apt-get -y install \
git \
cmake \
build-essential \
libboost-program-options-dev \
libboost-filesystem-dev \
libboost-graph-dev \
libboost-regex-dev \
libboost-system-dev \
libboost-test-dev \
libeigen3-dev \
libsuitesparse-dev \
libfreeimage-dev \
libgoogle-glog-dev \
libgflags-dev \
libglew-dev \
qtbase5-dev \
libqt5opengl5-dev \
libcgal-dev \
libcgal-qt5-dev \
libatlas-base-dev \
libsuitesparse-dev \
meshlab
# ^ Installing Meshlab
RUN git clone https://ceres-solver.googlesource.com/ceres-solver \
&& cd ceres-solver && git checkout $(git describe --tags) \
&& mkdir build && cd build \
&& cmake .. -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF \
&& make \
&& make install
RUN git clone https://github.com/colmap/colmap.git \
&& cd colmap \
&& git checkout dev \
&& mkdir build \
&& cd build \
&& cmake .. \
&& make \
&& make install
