# Dockerfile for OpenPose
A docker build file for CMU openpose with python api support


## Requirements
- Nvidia docker runtime: https://github.com/NVIDIA/nvidia-docker
- CUDA 8.0 or higher on your host, check with `nvcc -V`

## Environment

- CUDA 8.0
- CuDNN 6
- Python 3

## Usage

clone this repository and execute the command:

``
sudo docker build -t openpose_cuda8:latest .
``

Then, you can run docker image with the following command:

``
sudo doker run -it --runtime=nvidia openpose_cuda8:latest /bin/bash
``