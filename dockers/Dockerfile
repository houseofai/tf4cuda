ARG CUDA_VERSION=11.1
ARG CUDNN_VERSION=8
# 16.04 or 18.04 (20.04 not yet available)
ARG UBUNTU_VERSION=18.04

FROM nvidia/cuda:${CUDA_VERSION}-cudnn${CUDNN_VERSION}-devel-ubuntu${UBUNTU_VERSION}

ARG TF_PACKAGE=tensorflow-2.4.0rc3-cp36-cp36m-linux_x86_64.whl
ARG PYTHON_VERSION=3.6

ENV NVIDIA_VISIBLE_DEVICES all
ENV PATH="/root/.local/bin:${PATH}"
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ="Europe/Paris"

# Update APT Cache
RUN apt-get update
# Add extra repo for Python 3.9
RUN apt-get install -y software-properties-common dialog apt-utils git nano
RUN add-apt-repository ppa:deadsnakes/ppa
# Update APT Cache
RUN apt-get update

# Install and setup Python version
RUN apt-get install -y python${PYTHON_VERSION}
RUN update-alternatives --install /usr/bin/python python /usr/bin/python$PYTHON_VERSION 1
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python"${PYTHON_VERSION}" 1

RUN apt-get -y install python3-dev python3-pip
COPY ${TF_PACKAGE} .
RUN python3 -m pip install ${TF_PACKAGE}

