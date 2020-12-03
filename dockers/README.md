
# Tensorflow for CUDA 11


## Build a Docker image with the generated Tensorflow package

By default, the following command looks for a Tensorflow package named `tensorflow-2.4.0rc3-cp36-cp36m-linux_x86_64.whl` in the current directory:
```
docker build -t tensorflow-cuda11:2.4.0rc3 -f dockers/Dockerfile .
```

To build an image with a different package, add the argument `TF_PACKAGE` to the command:
```
docker build -e TF_PACKAGE=our_wheel_package  -t tensorflow-cuda11:your_tf_version -f dockers/Dockerfile .
```
