#!/bin/sh
set -u
set -e

# install scl repos, epel
yum install -y centos-release-scl epel-release autoconf \
    && yum-config-manager --enable rhel-server-rhscl-7-rpms \

yum install -y openssl-devel

yum install -y automake fretype-devel \
    && yum install -y g++ gcc-c++ glibc-devel cmake3 make

yum install -y  libxml2-devel.x86_64 ncurses-devel openblas-devel.x86_64 boost-devel \
    && yum install -y  zlib-devel flex bison

#Various python libs

#ARROW_VERSION='0.12.0'
#ARROW_SHA1='2ede75769e12df972f0acdfddd53ab15d11e0ac2'
#ARROW_BUILD_TYPE='release'

# Download and build Apache Arrow
tee /etc/yum.repos.d/Apache-Arrow.repo <<REPO
[apache-arrow]
name=Apache Arrow
baseurl=https://dl.bintray.com/apache/arrow/centos/\$releasever/\$basearch/
gpgcheck=1
enabled=1
gpgkey=https://dl.bintray.com/apache/arrow/centos/RPM-GPG-KEY-apache-arrow
REPO

yum install -y epel-release
#yum install -y --enablerepo=epel arrow-devel # For C++
#yum install -y --enablerepo=epel arrow-glib-devel # For GLib (C)
#yum install -y --enablerepo=epel parquet-devel # For Apache Parquet C++
#yum install -y --enablerepo=epel parquet-glib-devel # For Parquet GLib (C)

#arrow
yum -y --enablerepo=epel install cmake arrow-devel.x86_64 arrow-python-devel.x86_64 parquet-devel.x86_64 arrow-dataset-devel.x86_64 plasma-devel.x86_64
# <<--- this needs to be set in executors and the VM \
export ARROW_PRE_0_15_IPC_FORMAT=1 
# <<--- this needs to be set in executors and the VM and when building
export ARROW_HOME=/usr
git clone https://github.com/apache/arrow.git -b apache-arrow-0.15.1
cd arrow && git checkout -b 0.15.1
cd python
PYARROW_CXXFLAGS="-std=c++11" python setup.py install

yum install -y --enablerepo=epel parquet-devel # For Apache Parquet C++
yum install -y --enablerepo=epel parquet-glib-devel # For Parquet GLib (C)


