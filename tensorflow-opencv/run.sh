#!/bin/bash
set -e

# Install modules
export PYTHONUSERBASE=/config/deps

echo "[Info] Updating PIP3.7"
pip3.7 install --upgrade pip

echo "[Info] Install OpenCV modules into deps"
PYPI="absl-py astor termcolor gast keras_applications keras_preprocessing numpy"

# shellcheck disable=SC2086
if ! pip3.7 install --user --no-cache-dir --prefix= --no-dependencies ${PYPI}; then
    echo "[Error] Can't install PyPI packages!"
    exit 1
fi

echo "[Info] Install TensorFlow into deps"
# shellcheck disable=SC2086
if ! pip3.7 install --user --no-cache-dir --prefix= --no-dependencies /tensorflow-1.13.2-cp37-cp37m-linux_x86_64.whl; then
    echo "[Error] Can't install TensorFlow package!"
    exit 1
fi

echo "[Info] Install OpenCV into deps"
# shellcheck disable=SC2086
mv /opencv_python-4.1.2-py3-none-any.whl /opencv-4.1.2-py3-none-any.whl
if ! pip3.7 install --user --no-cache-dir --prefix= --no-dependencies /opencv-4.1.2-py3-none-any.whl; then
    echo "[Error] Can't install OpenCV package!"
    exit 1
fi

cp /cv2.so /config/deps/lib/python3.7/site-packages/cv2/cv2.so
mkdir /config/deps/lib/python3.7/site-packages/cv2/.libs/


echo "[INFO] Everything is installed and ready for use"
