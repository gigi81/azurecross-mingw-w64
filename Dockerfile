FROM gigi81/azurecross:base
MAINTAINER Luigi Grilli "luigi.grilli@gmail.com"

RUN apt-get update && apt install --fix-missing --yes \
autoconf \
automake \
autopoint \
bash \
bison \
bzip2 \
flex \
g++ \
g++-multilib \
gettext \
git \
gperf \
intltool \
libc6-dev-i386 \
libgdk-pixbuf2.0-dev \
libltdl-dev \
libssl-dev \
libtool-bin \
libxml-parser-perl \
lzip \
make \
openssl \
p7zip-full \
patch \
perl \
pkg-config \
python \
ruby \
sed \
unzip \
wget \
xz-utils \
wine-development \
wine64-development \
yasm

WORKDIR /
RUN git clone https://github.com/mxe/mxe && \
cd mxe && \
make cc --jobs=4 JOBS=2 MXE_TARGETS="x86_64-w64-mingw32.shared x86_64-w64-mingw32.static"

WORKDIR /azp

ENV TC_PROCESSOR amd64
ENV TC_TRIPLE x86_64-w64-mingw32.shared
ENV TC_ROOT=/mxe/usr
ENV CMAKE_TOOLCHAIN_FILE=/azp/toolchain.cmake

ENV AS=${TC_ROOT}/bin/${TC_TRIPLE}-as \
    AR=${TC_ROOT}/bin/${TC_TRIPLE}-ar \
    CC=${TC_ROOT}/bin/${TC_TRIPLE}-gcc-win32 \
    CPP=${TC_ROOT}/bin/${TC_TRIPLE}-cpp-win32 \
    CXX=${TC_ROOT}/bin/${TC_TRIPLE}-g++-win32 \
    LD=${TC_ROOT}/bin/${TC_TRIPLE}-ld \
    FC=${TC_ROOT}/bin/${TC_TRIPLE}-gfortran

ENV QEMU_LD_PREFIX "${TC_ROOT}/${TC_TRIPLE}"
ENV QEMU_SET_ENV "LD_LIBRARY_PATH=${TC_ROOT}/lib:${QEMU_LD_PREFIX}"

ENV PKG_CONFIG_PATH /mxe/usr/bin/x86_64-w64-mingw32.shared-pkg-config

CMD ["./start.sh"]
