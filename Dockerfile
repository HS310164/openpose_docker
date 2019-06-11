FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

#get deps
RUN apt-get -y --no-install-recommends update && \
apt-get -y --no-install-recommends upgrade && \
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
build-essential python3-dev python3-tk python3-pip python-setuptools git g++ wget make \
libprotobuf-dev protobuf-compiler libopencv-dev libgoogle-glog-dev libboost-all-dev \
libhdf5-dev libatlas-base-dev opencl-headers && \
ldconfig && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

#for python api
RUN pip install --upgrade pip setuptools
RUN pip3 install numpy opencv-python scipy 

#replace cmake as old version has CUDA variable bugs
RUN wget https://github.com/Kitware/CMake/releases/download/v3.14.2/cmake-3.14.2-Linux-x86_64.tar.gz && \
tar xzf cmake-3.14.2-Linux-x86_64.tar.gz -C /opt && \
rm cmake-3.14.2-Linux-x86_64.tar.gz
ENV PATH="/opt/cmake-3.14.2-Linux-x86_64/bin:${PATH}"

#get openpose
WORKDIR /openpose
RUN git clone https://github.com/CMU-Perceptual-Computing-Lab/openpose.git .

#build it
WORKDIR /openpose/build
RUN cmake -DBUILD_PYTHON=ON .. && make -j"$(nproc)"
RUN echo 'export PYTHONPATH="/openpose/build/python/openpose"' > ~/.bashrc
RUN echo 'alias python=python3' > ~/.bashrc
RUN echo 'alias pip=pip3' > ~/.bashrc
WORKDIR /openpose