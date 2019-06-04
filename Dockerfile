FROM centos:latest
# Based on installation instructions located at https://colmap.github.io/install.html
RUN yum update -y
RUN yum install -y wget && wget https://cmake.org/files/v3.6/cmake-3.6.2.tar.gz && tar -zxvf cmake-3.6.2.tar.gz && cd cmake-3.6.2 && ./bootstrap --prefix=/usr/local && make && make install \
    && yum install -y \
    git \
    gcc gcc-c++ make \
    boost-devel \
    eigen3-devel \
    suitesparse-devel \
    freeimage \
    glog-devel \
    gflags-devel \
    glew-devel \
    qt5-qtbase \
    qt5-qtbase-gui \
    CGAL \
    qt5-qtbase-devel \
    atlas-devel \
    suitesparse-devel

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
