
# Tensorflow for CUDA 11

As of today 03/12/2020, Tensorflow does not yet support officially Cuda 11. One way to bypass this limitation is to compile Tensorflow from the source using the Cuda 11 library.
But compiling Tensorflow and generating a PIP package is painful due to the environment setup.

TF4Cuda offers a Docker image based on Nvidia images with the latest Cuda version, and it setups all the dependencies packages for compiling Tensorflow. It makes it easy to generate a custom PIP package for a specific version of Tensorflow and a specific version of Python.

To start, you can use:
 - `docker run` to pull, run, and generate the pip package. See **Generate Tensorflow pip package for Cuda 11**
 - `docker build` to generate a new image and choose the Cuda, Cudnn, and Ubuntu version. See **Build the image for custom compilation**

## Generate Tensorflow pip package for Cuda 11

Use the Docker Run command to compile and generate a Tensorflow PIP package for Cuda 11.1 

To configure the compilation parameters, 
 - **TF_VERSION**: Tensorflow branch. Default to master
 - **PYTHON_VERSION**: Python version. Default to 3.9
 - **N_JOBS**: Number of Bazel Jobs. Default to 12 (Should be less than the maximum number of the CPU threads)
 
#### 1. Run the image
```
docker run -it --rm -v $PWD:/tmp/tensorflow_pkg odyssee/tf4cuda
```
To change the parameters, add `-e`, to the command line. For example, to build the PIP package for tensorflow 2.4.0-rc3
```
docker run -it --rm -v $PWD:/tmp/tensorflow_pkg -e TF_VERSION=v2.4.0-rc3  odyssee/tf4cuda
```
*Note: The Tensorflow tag is used as the parameter. For version 2.4.0-rc3, the tag is 'v2.4.0-rc3'. Check the Tensorflow Github tags for more information*

Once finished, the docker image builds a PIP package in the current directory, named:
```
tensorflow-${TF_VERSION}-cp${PYTHON_VERSION}-cp${PYTHON_VERSION}-linux_x86_64.whl
```
For example, for Tensorflow 2.5.0 and python 3.9, the generated package is:
```
tensorflow-2.5.0-cp39-cp39-linux_x86_64.whl
```
#### 2. Install the package
Finally, you can install it using PIP:
```
pip install tensorflow-2.5.0-cp39-cp39-linux_x86_64.whl
```

## Build the Docker image for Tensorflow with a custom Cuda version
By default, this image uses:
 - **CUDA_VERSION**: Cuda version. Default to 11.1
 - **CUDNN_VERSION**: CuDNN version. Default to 8
 - **UBUNTU_VERSION**: Ubuntu version. Default to 18.04
 - **PYTHON_VERSION**: Python version for installing PIP packages. Default to 3.6
```
docker build -t tf4cuda .
```
