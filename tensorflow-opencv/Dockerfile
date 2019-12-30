ARG BUILD_FROM="homeassistant/amd64-base-python:3.7"
FROM $BUILD_FROM

RUN apk update && \
    apk add \
        build-base \
        cmake \
        git \
        wget \
        unzip \
        yasm \
        jpeg-dev \
        tiff-dev \
        ffmpeg-dev \
        linux-headers \
        ninja

RUN pip install numpy==1.18.0

WORKDIR /
ENV OPENCV_VERSION="4.1.2"
RUN wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip \
&& unzip ${OPENCV_VERSION}.zip \
&& rm -f ${OPENCV_VERSION}.zip

RUN mkdir /opencv-${OPENCV_VERSION}/cmake_binary \
&& cd /opencv-${OPENCV_VERSION}/cmake_binary \
&& cmake -DBUILD_TIFF=ON \
  -DBUILD_opencv_java=OFF \
  -DWITH_CUDA=OFF \
  -DWITH_OPENGL=ON \
  -DWITH_OPENCL=ON \
  -DWITH_IPP=ON \
  -DWITH_TBB=ON \
  -DWITH_EIGEN=ON \
  -DWITH_V4L=ON \
  -DBUILD_TESTS=OFF \
  -DBUILD_PERF_TESTS=OFF \
  -DCMAKE_BUILD_TYPE=RELEASE \
  -DCMAKE_INSTALL_PREFIX=$(python3.7 -c "import sys; print(sys.prefix)") \
  -DPYTHON_EXECUTABLE=$(which python3.7) \
  -DPYTHON_INCLUDE_DIR=$(python3.7 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
  -DPYTHON_PACKAGES_PATH=$(python3.7 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
  .. \
&& make -j$(nproc) 

RUN find /opencv-${OPENCV_VERSION}/ | grep setup.py
RUN find /opencv-${OPENCV_VERSION}/ -name \*.so 

WORKDIR /opencv-${OPENCV_VERSION}/modules/python/package/
RUN python setup.py bdist_wheel

RUN wget https://github.com/evdcush/TensorFlow-wheels/releases/download/tf-1.13.1-py37-gpu-10.0/tensorflow-1.13.1-cp37-cp37m-linux_x86_64.whl -o /tensorflow-1.13.1-cp37-cp37m-linux_x86_64.whl

# Copy data
RUN mv /opencv-${OPENCV_VERSION}/modules/python/package/dist/opencv-${OPENCV_VERSION}-py3-none-any.whl /opencv_python-${OPENCV_VERSION}-py3-none-any.whl
COPY run.sh /
RUN chmod a+x /run.sh

WORKDIR /data
CMD ["/run.sh"]
