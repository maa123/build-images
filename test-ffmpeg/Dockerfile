FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    software-properties-common \
    wget \
    cmake \
    build-essential \
    pkg-config \
    yasm \
    git \
    nasm \
    libva-dev \
    vainfo \
    libdrm-dev \
    libpciaccess-dev \
    libnuma-dev \
    autoconf \
    automake \
    libtool \
    && apt-get clean

RUN git clone https://github.com/mstorsjo/fdk-aac.git /fdk-aac \
    && cd /fdk-aac \
    && autoreconf -fiv \
    && ./configure --prefix=/usr/local --disable-shared \
    && make -j$(nproc) \
    && make install \
    && cd .. \
    && rm -rf /fdk-aac

RUN wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | gpg --dearmor > /usr/share/keyrings/oneapi-archive-keyring.gpg

RUN echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" > /etc/apt/sources.list.d/oneAPI.list

RUN apt-get update && apt-get install -y intel-basekit libvpl-dev

RUN git clone https://github.com/intel/vpl-gpu-rt vpl-gpu-rt \
    && cd /vpl-gpu-rt \
    && mkdir build && cd build \
    && cmake .. \
    && make -j$(nproc) \
    && make install \
    && cd ../.. \
    && rm -rf /vpl-gpu-rt

RUN git clone https://git.ffmpeg.org/ffmpeg.git /ffmpeg \
    && cd /ffmpeg \
    && ./configure \
        --enable-gpl \
        --enable-libx264 \
        --enable-libvpx \
        --enable-libmp3lame \
        --enable-libfdk-aac \
        --enable-vaapi \
        --enable-libvpl \
        --enable-nonfree \
    && make -j$(nproc) \
    && make install \
    && make distclean

RUN ffmpeg -f lavfi -i testsrc=duration=10:size=1280x720:rate=30 /workspace/input.mp4

RUN echo '#!/bin/bash\n\
vainfo\n\
ffmpeg -hwaccel qsv -c:v h264_qsv -i /workspace/input.mp4 -c:v h264_qsv /workspace/output.mp4\n\
echo "Intel QSV encoding complete!"' > /test_qsv.sh \
    && chmod +x /test_qsv.sh

WORKDIR /workspace

ENTRYPOINT ["/test_qsv.sh"]
