FROM centos:latest
# Based on installation instructions located at https://colmap.github.io/install.html
RUN yum update -y
RUN yum install -y \
    git \
    cmake cmake3 \
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
    
RUN alternatives --install /usr/local/bin/cmake cmake /usr/bin/cmake 10 \
--slave /usr/local/bin/ctest ctest /usr/bin/ctest \
--slave /usr/local/bin/cpack cpack /usr/bin/cpack \
--slave /usr/local/bin/ccmake ccmake /usr/bin/ccmake \
--family cmake

RUN alternatives --install /usr/local/bin/cmake cmake /usr/bin/cmake3 20 \
--slave /usr/local/bin/ctest ctest /usr/bin/ctest3 \
--slave /usr/local/bin/cpack cpack /usr/bin/cpack3 \
--slave /usr/local/bin/ccmake ccmake /usr/bin/ccmake3 \
--family cmake

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
