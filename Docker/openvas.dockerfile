FROM debian:buster
ARG VERSION=20.08
WORKDIR  /usr/local/src
RUN apt-get update
RUN echo 'Dir::Cache "";' > /etc/apt/apt.conf.d/00_disable-cache-directories && \
echo 'Dir::Cache::archives "";' >>  /etc/apt/apt.conf.d/00_disable-cache-directories
RUN apt-get install -y git gcc cmake pkg-config gcc-mingw-w64 libgnutls28-dev heimdal-dev \
libpopt-dev libglib2.0-dev libgpgme-dev libssh-gcrypt-dev libldap2-dev libhiredis-dev \
libxml2-dev libradcli-dev libpcap-dev bison libksba-dev libsnmp-dev python3-pip \
libpq-dev postgresql-server-dev-11 libical-dev xsltproc libmicrohttpd-dev gettext
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && apt-get install -y nodejs && \
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn
RUN git clone https://github.com/greenbone/openvas-smb && \
git clone --branch gsa-${VERSION} https://github.com/greenbone/gsa.git && \
git clone --branch ospd-openvas-${VERSION} https://github.com/greenbone/ospd-openvas.git && \
git clone --branch gvmd-${VERSION} https://github.com/greenbone/gvmd.git && \
git clone --branch gvm-libs-${VERSION} https://github.com/greenbone/gvm-libs.git && \
git clone --branch openvas-${VERSION} https://github.com/greenbone/openvas.git && \
git clone --branch ospd-${VERSION} https://github.com/greenbone/ospd.git
RUN mkdir -p openvas-smb/build && cd openvas-smb/build && cmake .. && make && make install && cd ../.. && \
mkdir -p gvm-libs/build && cd gvm-libs/build && cmake .. && make && make install && cd ../.. && \
mkdir -p openvas/build && cd openvas/build && cmake .. && make && make install && cd ../.. && \
cd ospd && python3 -m pip install . && cd .. && \
cd ospd-openvas && python3 -m pip install . && cd .. && \
mkdir -p gvmd/build && cd gvmd/build && cmake .. && make && make install && cd ../.. && \
mkdir -p gsa/build && cd gsa/build && cmake .. && make && make install && cd ../.. && \
cd .. && rm -fR src
RUN apt-get remove -y gettext gettext-doc autopoint libasprintf-dev libgettextpo-dev \
libmicrohttpd-dev \
libical-dev libdb-dev libdb5.3-dev \
postgresql-server-dev-11 cron exim4-base exim4-config exim4-daemon-light \
libclang-common-7-dev libncurses-dev libobjc-8-dev libtinfo-dev llvm-7-dev \
libpq-dev mailutils mailutils-common logrotate \
python3-pip \
libsnmp-dev libpci-dev libsensors-config libsensors4-dev libsensors5 libssl-dev \
libudev-dev libwrap0-dev libmariadb3 \
libksba-dev \
libbison-dev \
libpcap0.8-dev \
libradcli-dev \
libxml2-dev icu-devtools libicu-dev \
libhiredis-dev \
libldap2-dev \
libssh-gcrypt-dev libgcrypt20-dev \
libgpgme-dev libassuan-dev libgpg-error-dev \
libglib2.0-dev libblkid-dev libffi-dev libglib2.0-dev-bin libmount-dev libpcre3-dev libselinux1-dev \
libsepol1-dev uuid-dev zlib1g-dev \
libpopt-dev \
heimdal-dev comerr-dev heimdal-multidev \
libgnutls28-dev libgmp-dev libidn2-dev libp11-kit-dev libtasn1-6-dev nettle-dev \
gcc-mingw-w64 binutils-mingw-w64-i686 binutils-mingw-w64-x86-64 gcc-mingw-w64-base gcc-mingw-w64-i686 \
gcc-mingw-w64-x86-64 mingw-w64-common mingw-w64-i686-dev mingw-w64-x86-64-dev \
pkg-config libdpkg-perl libfile-fcntllock-perl liblocale-gettext-perl \
cmake cmake-data make shared-mime-info \
gcc cpp cpp-8 gcc-8 libc-dev-bin libc6-dev libgcc-8-dev linux-libc-dev manpages manpages-dev \
git git-man less patch perl perl-modules-5.28 xauth
CMD ["/bin/sh"]
