# Build Tensorflow with GPU support from the source
[Instructions from the official site](https://www.tensorflow.org/install/source)

### First prepare the image and start a container instance
```
make build
make packing
```

### Then, within the container's virtual environment, build the TensorFlow package with GPU support:
```
./configure  # answer prompts or use defaults
bazel build --config=opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
./bazel-bin/tensorflow/tools/pip_package/build_pip_package /mnt  # create package
chown $HOST_PERMS /mnt/tensorflow-version-tags.whl
```

### Install and verify the package within the container and check for a GPU:
```
pip uninstall tensorflow  # remove current version
pip install /mnt/tensorflow-version-tags.whl
cd /tmp  # don't import from source directory
python -c "import tensorflow as tf; print(tf.contrib.eager.num_gpus())"
```
