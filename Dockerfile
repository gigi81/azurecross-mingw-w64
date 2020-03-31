FROM gigi81/azurecross:base
MAINTAINER Luigi Grilli "luigi.grilli@gmail.com"

ENV TC_PROCESSOR amd64
ENV TC_TRIPLE i686-w64-mingw32
ENV TC_ROOT=/usr
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

ENV PKG_CONFIG_PATH /usr/lib/${TC_TRIPLE}/pkgconfig

WORKDIR /azp

RUN apt install --no-install-recommends --yes \
binutils-mingw-w64-i686 \
binutils-mingw-w64-x86-64 \
g++-mingw-w64 \
g++-mingw-w64-i686 \
g++-mingw-w64-x86-64 \
gcc-mingw-w64 \
gcc-mingw-w64-base \
gcc-mingw-w64-i686 \
gcc-mingw-w64-x86-64 \
gfortran-mingw-w64 \
gfortran-mingw-w64-i686 \
gfortran-mingw-w64-x86-64 \
mingw-w64 \
mingw-w64-common \
mingw-w64-tools \
mingw-w64-i686-dev \
mingw-w64-x86-64-dev \
gcc-7-locales \ 
wine-development \
wine64-development \
&& export

CMD ["./start.sh"]
