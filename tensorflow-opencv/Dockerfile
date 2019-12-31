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
        libjpeg-turbo-dev \
        libpng-dev \
        tiff-dev \
        libwebp-dev \
        clang-dev \
        ffmpeg-dev \
        linux-headers \
        ninja

RUN pip install numpy

WORKDIR /
ENV OPENCV_VERSION="4.1.2"
RUN wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip \
&& unzip ${OPENCV_VERSION}.zip \
&& rm -f ${OPENCV_VERSION}.zip

RUN mkdir /opencv-${OPENCV_VERSION}/build \
&& cd /opencv-${OPENCV_VERSION}/build \
&& cmake \
      -D CMAKE_BUILD_TYPE=RELEASE \
      -D WITH_FFMPEG=NO \
      -D WITH_IPP=NO \
      -D WITH_OPENEXR=NO \
      -D WITH_TBB=YES \
      -D BUILD_EXAMPLES=NO \
      -D BUILD_ANDROID_EXAMPLES=NO \
      -D INSTALL_PYTHON_EXAMPLES=NO \
      -D BUILD_DOCS=NO \
      -D BUILD_opencv_python2=NO \
      -D BUILD_opencv_python3=ON \
      -D BUILD_TESTS=OFF \
      -D BUILD_PERF_TESTS=OFF \
#      -D CMAKE_INSTALL_PREFIX=$(python3.7 -c "import sys; print(sys.prefix)") \
#      -D PYTHON_EXECUTABLE=$(which python3.7) \
#      -D PYTHON_INCLUDE_DIR=$(python3.7 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
#      -D PYTHON_PACKAGES_PATH=$(python3.7 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
      -G Ninja .. \
&& ninja
#&& make -j$(nproc) 

RUN find /opencv-${OPENCV_VERSION}/ | grep setup.py
RUN find /opencv-${OPENCV_VERSION}/ -name \*.so 

RUN mv /opencv-4.1.2/build/lib/python3/cv2.cpython-37m-x86_64-linux-gnu.so /cv2.so

#WORKDIR /opencv-${OPENCV_VERSION}/modules/python/package/
#RUN python setup.py bdist_wheel

RUN wget https://github.com/AfsmNGhr/alpine-tensorflow/releases/download/tensorflow-1.13.2/tensorflow-1.13.2-cp37-cp37m-linux_x86_64.whl -O tensorflow-1.13.2-cp37-cp37m-linux_x86_64.whl

# Copy data
#RUN mv /opencv-${OPENCV_VERSION}/modules/python/package/dist/opencv-${OPENCV_VERSION}-py3-none-any.whl /opencv_python-${OPENCV_VERSION}-py3-none-any.whl
#COPY opencv_python-4.1.2.30-cp37-cp37m-manylinux1_x86_64.whl /
COPY run.sh /
RUN chmod a+x /run.sh

RUN rm -rf /opencv-${OPENCV_VERSION} \
    && rm -rf /var/cache/apk/*

WORKDIR /data
CMD ["/run.sh"]
