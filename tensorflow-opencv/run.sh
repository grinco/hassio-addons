#!/bin/bash
set -e

# Install modules
export PYTHONUSERBASE=/config/deps

echo "[Info] Install OpenCV modules into deps"
PYPI="absl-py astor termcolor gast keras_applications keras_preprocessing numpy"

# shellcheck disable=SC2086
if ! pip3 install --user --no-cache-dir --prefix= --no-dependencies ${PYPI}; then
    echo "[Error] Can't install PyPI packages!"
    exit 1
fi

echo "[Info] Install TensorFlow into deps"
# shellcheck disable=SC2086
if ! pip3 install --user --no-cache-dir --prefix= --no-dependencies /tensorflow-1.13.1-cp37-cp37m-linux_x86_64.whl; then
    echo "[Error] Can't install TensorFlow package!"
    exit 1
fi

echo "[Info] Install OpenCV into deps"
# shellcheck disable=SC2086
if ! pip3 install --user --no-cache-dir --prefix= --no-dependencies /opencv_python-4.1.2-py3-none-any.whl; then
    echo "[Error] Can't install OpenCV package!"
    exit 1
fi

cp /opencv-4.1.2/build/lib/python3/cv2.cpython-37m-x86_64-linux-gnu.so /config/deps/lib/python3.7/site-packages/cv2.so 

echo "[INFO] OpenCV is installed and ready for use"
