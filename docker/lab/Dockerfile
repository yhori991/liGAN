FROM nvidia/cuda:11.0-devel-ubuntu20.04
ENV DEBIAN_FRONTEND noninteractive
# --- cuda-toolkit ---
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils gnupg2 curl \
&& curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub | apt-key add - \
&& echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/cuda.list \
&& echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list \
&& apt update && apt install -y cuda-toolkit-11-0 \
&& rm -rf /var/lib/apt/lists

# --- CMake ---
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libssl-dev \
    wget \
&& apt-get clean -y \
&& rm -rf /var/lib/apt/lists
RUN wget https://github.com/Kitware/CMake/releases/download/v3.20.2/cmake-3.20.2.tar.gz \
&& tar -zxvf cmake-3.20.2.tar.gz \
&& cd cmake-3.20.2 \
&& ./bootstrap \
&& make -j $(nproc) \
&& make install \
&& cd /

# --- Python3 ---
RUN apt-get update \
&& apt-get install -y --no-install-recommends \
    ca-certificates \
    python3 \
    python3-dev \
    python3-setuptools \
    python3-pip \
    python3-numpy \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.8 2
RUN update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 2

# --- RDKit ---
RUN pip install rdkit-pypi

# --- OpenBabel ---
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    wget \
    libboost-all-dev \
    libeigen3-dev \
    libgoogle-glog-dev \
    libprotobuf-dev \
    libschroedinger-maeparser-dev \
    libschroedinger-coordgenlibs-dev \
    protobuf-compiler \
    libhdf5-dev \
    libatlas-base-dev \
    libxml2-dev \
    swig3.0 \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel \
&& apt-get clean -y \
&& rm -rf /var/lib/apt/lists
RUN git clone https://github.com/openbabel/openbabel.git \
&& cd openbabel \
&& mkdir build \
&& cd build \
&& cmake .. \
  -DWITH_MAEPARSER=OFF \
  -DWITH_COORDGEN=OFF \
  -DPYTHON_EXECUTABLE=/usr/bin/python \
  -DPYTHON_BINDINGS=ON \
  -DRUN_SWIG=ON \
&& make -j $(nproc) \
&& make install \
&& cd /

# --- Gnina ---
ENV CUDACXX=/usr/local/cuda/bin/nvcc
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    wget \
    libboost-all-dev \
    libeigen3-dev \
    libgoogle-glog-dev \
    libprotobuf-dev \
    protobuf-compiler \
    libhdf5-dev \
    libatlas-base-dev \
    python3-dev \
    librdkit-dev \
    python3-numpy \
    python3-pip \
    python3-pytest \
&& apt-get clean -y \
&& rm -rf /var/lib/apt/lists
RUN git clone https://github.com/gnina/gnina.git \
&& cd gnina \
&& mkdir build \
&& cd build \
&& cmake .. \
&& make -j $(nproc) \
&& make install \
&& cd /
# caffe in Gnina
ENV PYTHONPATH=/usr/local/python:$PYTHONPATH

# --- liGAN ---
RUN git clone https://github.com/mattragoza/liGAN.git
RUN pip install \
    numpy \
    pandas \
    scikit-image \
    molgrid \
    torch \
    protobuf
