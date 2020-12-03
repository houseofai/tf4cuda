ARG PYTHON_VERSION=3.6
ARG CUDA_VERSION=11.1
ARG CUDNN_VERSION=8
# 16.04 or 18.04 (20.04 not yet available)
ARG UBUNTU_VERSION=18.04

FROM nvidia/cuda:${CUDA_VERSION}-cudnn${CUDNN_VERSION}-devel-ubuntu${UBUNTU_VERSION}

ENV NVIDIA_VISIBLE_DEVICES all
ENV PATH="/root/.local/bin:${PATH}"
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ="Europe/Paris"

# Update APT Cache
RUN apt-get update

# Add extra repo for Python 3.9
RUN apt-get install -y software-properties-common dialog apt-utils
RUN add-apt-repository ppa:deadsnakes/ppa

# Update APT Cache
RUN apt-get update

# Install and setup Python version
RUN apt-get install -y python3.5 python3.6 python3.7 python3.8 python3.9
RUN alias python='/usr/bin/python$PYTHON_VERSION'

RUN apt-get -y install git npm apt-utils

# Tensorflow: build from source
# https://www.tensorflow.org/install/source?hl=en#configuration_options

# Setup for Linux
RUN apt-get -y install python3-dev python3-pip
RUN pip3 install -U --user pip six numpy wheel setuptools mock 'future>=0.17.1'
RUN pip3 install -U --user keras_applications --no-deps
RUN pip3 install -U --user keras_preprocessing --no-deps

# Install Bazel
RUN npm install -g @bazel/bazelisk

WORKDIR workspace

# Download the TensorFlow source code
RUN git clone https://github.com/tensorflow/tensorflow.git
# or copy it from the current directory
COPY . .

COPY .tf_configure.bazelrc /workspace/tensorflow

# Compilation variables
# Number of jobs for Bazel
ENV N_JOBS=12
ENV PYTHON_VERSION=3.6
ENV TF_VERSION=master

CMD ["sh", "/workspace/generate.sh"]