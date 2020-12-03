#!/bin/bash

# shellcheck disable=SC2139
#alias python="/usr/bin/python${PYTHON_VERSION}"
update-alternatives --install /usr/bin/python python /usr/bin/python"${PYTHON_VERSION}" 1
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python"${PYTHON_VERSION}" 1
#update-alternatives --set python /usr/bin/python"${PYTHON_VERSION}"

echo "Python version: $(python --version)"
echo "Number of Bazel jobs: ${N_JOBS}"
echo "Bazel's parameters: $(cat .tf_configure.bazelrc)"

# Download the TensorFlow source code
# git clone https://github.com/tensorflow/tensorflow.git
# shellcheck disable=SC2164
cd /workspace/tensorflow
echo "Pull latest Tensorflow code"
git pull

# Configure the build
if [ "$TF_VERSION" != "master" ];
then
  echo "Pulling from branch $TF_VERSION"
  git checkout -q "$TF_VERSION"
fi

# Configure the build
#RUN ./configure

# Build the pip packages
bazel build --jobs="$N_JOBS" //tensorflow/tools/pip_package:build_pip_package

# Build the packages
./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg

