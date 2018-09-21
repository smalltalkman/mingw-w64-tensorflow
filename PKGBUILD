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
            '7B643AF4AD338E475663DFCB155B812265E9042113BF70F774F437A6366A4341'
            '8D307EE52BE3A6453D124C3601453268EC1AF76A92B9D95B9576776BC46E6456'
            '37FB53852796A9DF3BFE12897333B9DB28FFAC3C59A3B3762943C6AF62E94332'
            '8C8858AD675D5D69520166265751F2EAAD48EA0EB36BE299F4743389E879FAD9'
            '87856D1C91367FD99407E50327B98900F816DF983B669C192D2E9E6334637AD3')

arch=('any')
depends=()
makedepends=("${MINGW_PACKAGE_PREFIX}-swig")

prepare() {
  cd "${srcdir}/tensorflow-${pkgver}"
  if [ ! -d .git ]; then
    git init
    git add .
    git commit -m "first commit"
  fi
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
