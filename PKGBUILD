_realname=tensorflow

pkgbase=mingw-w64-${_realname}
pkgname="${MINGW_PACKAGE_PREFIX}-${_realname}"
pkgver=1.10.0
pkgrel=1
pkgdesc="An Open Source Machine Learning Framework for Everyone"

license=('Apache License 2.0')
url="https://tensorflow.org"
source=(https://github.com/tensorflow/tensorflow/archive/v${pkgver}.tar.gz
        MinGW-endian.h
        patches-nsync-platform-win32-platform_c++11_os.h
        patches-nsync-platform-win32-src-pthread_key_win32.cc
        patches-grpc-CMakeLists.txt
        patches-png-CMakeLists.txt
        all.diff)
sha256sums=('EE9CB98D9E0D8106F2F4ED52A38FE89399324AF303E1401567E5B64A9F86744B'
            '083AFEC53265F2E67940458146398B8CB061A4470BBFFA628DFC909B5A6A1EF4'
            '9FE1AEC7932B15C864449CF160CF0F4F61F10AF08E39E52759D183DD4E8CE4BB'
            '1462F611AD4BF66BD181C9AD177A7C502CAEF5797DE22F38619C99CA3C65DC44'
            '6B3EBD1FD3932E6FD0103CFB525B3BDB3A3177C186E4E8F638F2682D4D76036D'
            '8C8858AD675D5D69520166265751F2EAAD48EA0EB36BE299F4743389E879FAD9'
            '1807224D4D1CB3BDBAF6B4548C153F17F428360893A2A0304A9B74B649F86B9E')

arch=('any')
depends=()
makedepends=()

prepare() {
  cd "${srcdir}/tensorflow-${pkgver}"
  # if [ ! -d .git ]; then
  #   git init
  #   git add .
  #   git commit -m "first commit"
  # fi
  mkdir -p tensorflow/contrib/cmake/patches/nsync
  cp -ubS.orig -p         ${srcdir}/patches-nsync-platform-win32-platform_c++11_os.h \
           tensorflow/contrib/cmake/patches/nsync/platform-win32-platform_c++11_os.h
  cp -ubS.orig -p         ${srcdir}/patches-nsync-platform-win32-src-pthread_key_win32.cc \
           tensorflow/contrib/cmake/patches/nsync/platform-win32-src-pthread_key_win32.cc
  mkdir -p tensorflow/contrib/cmake/patches/grpc
  cp -ubS.orig -p         ${srcdir}/patches-grpc-CMakeLists.txt \
           tensorflow/contrib/cmake/patches/grpc/CMakeLists.txt
  mkdir -p tensorflow/contrib/cmake/patches/png
  cp -ubS.orig -p         ${srcdir}/patches-png-CMakeLists.txt \
           tensorflow/contrib/cmake/patches/png/CMakeLists.txt
  mkdir -p tensorflow/contrib/cmake/patches/farmhash
  cp -ubS.orig -p         ${srcdir}/MinGW-endian.h \
           tensorflow/contrib/cmake/patches/farmhash/MinGW-endian.h
  patch -b -p1 -i ${srcdir}/all.diff
}

build() {
  cd "${srcdir}/tensorflow-${pkgver}"
  mkdir -p cmake_build
  cd cmake_build
  cmake -G "MSYS Makefiles" ../tensorflow/contrib/cmake
  make -j1
}

package() {
  cd "${srcdir}/tensorflow-${pkgver}"
  cd cmake_build
  make DESTDIR="${pkgdir}/" install
}
